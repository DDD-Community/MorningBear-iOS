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
            "Authorization": "Bearer JuqYy0ScmYq4NDRe0mD2o9XxXZ8bkG1X4h66zu3lt/tWJZylGBtLUuZD5mGEFrWD7rhCJGUn78a/Q+h55ec8TQ=="
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

class NetworkInterceptorProvider: DefaultInterceptorProvider {
    override func interceptors<Operation: GraphQLOperation>(for operation: Operation) -> [ApolloInterceptor] {
        var interceptors = super.interceptors(for: operation)
        interceptors.insert(CustomInterceptor(), at: 0)
        return interceptors
    }
}

class CustomInterceptor: ApolloInterceptor {
    func interceptAsync<Operation: GraphQLOperation>(
        chain: RequestChain,
        request: HTTPRequest<Operation>,
        response: HTTPResponse<Operation>?,
        completion: @escaping (Swift.Result<GraphQLResult<Operation.Data>, Error>) -> Void) {
        request.addHeader(name: "Authorization",
                          value: "Bearer UXve76eMe1aZXd/oMJgKCfeSHvoj5ZrSPrzMljqxK3NKQkwq/24Yj8pec9t3mlRQnWI4gCw8d37I19er1Xwr9Q==")
        
        print("request :\(request)")
        print("response :\(String(describing: response))")
        
        chain.proceedAsync(request: request,
                           response: response,
                           completion: completion)
    }
}
