//
//  Network.swift
//  MorningBearKit
//
//  Created by Young Bin on 2022/11/29.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

import Apollo
import ApolloAPI
import ApolloTestSupport

public class Network {
    public static let shared = Network()
    
    public private(set) lazy var apollo = setClient()
    
    private func setClient() -> ApolloClient {
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        
        // FIXME: 토큰 숨기기
        let authPayloads = [
            "Authorization": "Bearer cJBURfM5nHJe0fyOTkGz8Kmz/vrsayoC6gOHVWZZXsQtiI3nGyLXA/fO9qWCs9QvEtJL7bJRO1csDnk2lhF8XA=="
        ]
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = authPayloads
        
        let sessionClient = URLSessionClient(sessionConfiguration: configuration, callbackQueue: nil)
        let provider = NetworkInterceptorProvider(client: sessionClient, shouldInvalidateClientOnDeinit: true, store: store)
        
        let url = URL(string: "http://138.2.126.76:8080/graphql")!
        
        let requestChainTransport = RequestChainNetworkTransport(interceptorProvider: provider,
                                                                 endpointURL: url)
        
        let apolloClient = ApolloClient(networkTransport: requestChainTransport,
                                        store: store)
        
        return apolloClient
    }
}

/// 인터셉터들을 아폴로 클라이언트에 전달한다
fileprivate final class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        
        interceptors += [HeaderInterceptor()]
        interceptors += [RequestLoggingInterceptor()]
        
        return interceptors
    }
}

/// 리퀘스트를 스니핑하면서 로깅한다
fileprivate final class RequestLoggingInterceptor: ApolloInterceptor {
    private let showResponseBody = true
    
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            
            if let url = try? request.toURLRequest().url?.absoluteString.removingPercentEncoding {
                if let variables = request.operation.__variables {
                    print("[🛰️ Apollo 🛰️] REQUEST 📤: " + "\(Operation.operationName) \n" +
                          "↪️ Parameters: \(variables), to: \(url)")
                } else {
                    print("[🛰️ Apollo 🛰️] REQUEST 📤: " + "\(Operation.operationName) \n" +
                          "↪️ To: \(url)")
                }
            }
            
            if let response {
                print("[🛰️ Apollo 🛰️] RESPONSE 📨 of \(Operation.operationName): \n" +
                      "↪️ Http response: \(response.httpResponse)\n" +
                      (showResponseBody ? "↪️ Body: \(String(data: response.rawData, encoding: .utf8) ?? "")\n" : "")
                )
            }
            
            chain.proceedAsync(request: request, response: response, completion: completion)
        }
}

/// 헤더에 필요한 정보를 더한다
fileprivate final class HeaderInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
            
            request.addHeader(name: "Authorization",
                              value: "Bearer UXve76eMe1aZXd/oMJgKCfeSHvoj5ZrSPrzMljqxK3NKQkwq/24Yj8pec9t3mlRQnWI4gCw8d37I19er1Xwr9Q==")
            
            chain.proceedAsync(request: request, response: response,completion: completion)
        }
}
