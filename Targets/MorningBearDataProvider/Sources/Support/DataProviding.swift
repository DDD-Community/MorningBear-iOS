//
//  DataProviding.swift
//  MorningBearDataProvider
//
//  Created by Young Bin on 2023/01/23.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift

public protocol DataProviding {
    func fetch<Query: Queryable>(_ model: Query) -> Single<Query.ResultType>
}

extension DataProviding {
    public func fetch<Query>(_ model: Query) -> Single<Query.ResultType> where Query : Queryable {
        return model.singleTrait
    }
}

public protocol Queryable {
    associatedtype ResultType
    
    var singleTrait: Single<ResultType> { get }
}
