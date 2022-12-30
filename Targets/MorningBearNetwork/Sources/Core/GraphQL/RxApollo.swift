//
//  RxApollo.swift
//  MorningBearKit
//
//  Created by Young Bin on 2022/11/29.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

import Apollo
import ApolloAPI

import RxSwift

extension ApolloClient {
    var rx: RxApollo {
        return RxApollo(self)
    }
}

struct RxApollo {
    private let client: ApolloClient
    
    /// GraphQL에서 `query`에 해당하는 요청을 실행하고 결과를 `RxSwift.Observable` 타입으로 반환
    func fetch<T>(query: T) -> Single<GraphQLResult<T.Data>> where T: GraphQLQuery {
        let observable = Observable.createFromResultCallback { resultClosure in
            client.fetch(query: query, resultHandler: resultClosure)
        }
        
        return observable.asSingle()
    }
    
    /// GraphQL에서 `mutation`에 해당하는 요청을 실행하고 결과를 `RxSwift.Observable` 타입으로 반환
    func perform<T>(mutation: T) -> Single<GraphQLResult<T.Data>> where T: GraphQLMutation {
        let observable = Observable.createFromResultCallback { resultClosure in
            client.perform(mutation: mutation, resultHandler: resultClosure)
        }
        
        return observable.asSingle()
    }
    
    init(_ apolloClient: ApolloClient) {
        self.client = apolloClient
    }
}
