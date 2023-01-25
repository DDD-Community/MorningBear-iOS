//
//  Network + Mock.swift
//  MorningBearDataEditor
//
//  Created by Young Bin on 2023/01/23.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import Apollo
import ApolloAPI
import ApolloTestSupport

public final class MockNetworkTransport: NetworkTransport {
    let body: JSONObject
    
    public var clientName = "MockNetworkTransport"
    public var clientVersion = "mock_version"
    
    public func send<Operation>(operation: Operation,
                                cachePolicy: CachePolicy,
                                contextIdentifier: UUID?,
                                callbackQueue: DispatchQueue,
                                completionHandler: @escaping (Result<GraphQLResult<Operation.Data>, Error>) -> Void)
    -> Cancellable where Operation : GraphQLOperation {
        
        DispatchQueue.global(qos: .default).async {
            guard let result = try? GraphQLResponse(operation: operation, body: self.body).parseResult() else {
                completionHandler(.failure(URLError(.badServerResponse)))
                return
            }
                        
            completionHandler(.success(result.0))
        }
        
        return MockTask()
    }
    
    public init(body: JSONObject) {
        self.body = body
    }
}

private final class MockTask: Cancellable {
    func cancel() {}
}
