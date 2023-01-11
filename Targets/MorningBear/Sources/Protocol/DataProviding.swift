//
//  Dataproviding.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/10.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

protocol DataProviding {
    func fetch<Query: ModelQueryType>(_ query: Query) -> Query.QueryResult
    func mutate<Query: ModelQueryType>(_ query: Query, to value: Query.QueryResult)
}

extension DataProviding {
    func fetch<Query: ModelQueryType>(_ query: Query) -> Query.QueryResult {
        return query.fetch()
    }

    func mutate<Query: ModelQueryType>(_ query: Query, to value: Query.QueryResult) {
        query.mutate(to: value)
    }
}

protocol ModelType {}

protocol ModelQueryType {
    associatedtype QueryResult: ModelType
    
    func fetch() -> QueryResult
    func mutate(to value: QueryResult)
}
