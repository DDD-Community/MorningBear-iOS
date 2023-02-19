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

import MorningBearKit

public class Network {
    public static let shared = Network()
    private var token: String?
    
    public private(set) lazy var apollo: ApolloClient = setClient()
}

public extension Network {
    func registerToken(token: String) {
        self.token = token
        self.apollo = setClient()
    }
}

private extension Network {
    func setClient() -> ApolloClient {
        guard let token else {
            MorningBearLogger.track(NetworkError.tokenNotRegistered)
            
            return ApolloClient(url: URL(string: "about:blank")!) // any url
        }
        
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = [
            "Authorization" : "Bearer \(token)"
        ]
        
        let cache = InMemoryNormalizedCache()
        let store = ApolloStore(cache: cache)
        
        
        let sessionClient = URLSessionClient(sessionConfiguration: config, callbackQueue: nil)
        let provider = NetworkInterceptorProvider(client: sessionClient,
                                                  shouldInvalidateClientOnDeinit: true,
                                                  store: store)
        
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
                          "↪️ Header: \(request.additionalHeaders)\n" +
                          "↪️ Parameters: \(variables), to: \(url)")
                } else {
                    print("[🛰️ Apollo 🛰️] REQUEST 📤: " + "\(Operation.operationName) \n" +
                          "↪️ Header: \(request.additionalHeaders)\n" +
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

enum NetworkError: LocalizedError {
    case tokenNotRegistered
    
    var errorDescription: String? {
        switch self {
        case .tokenNotRegistered:
            return "토큰이 등록되지 않았습니다"
        }
    }
}
