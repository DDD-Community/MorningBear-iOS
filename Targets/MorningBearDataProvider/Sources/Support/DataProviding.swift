//
//  DataProviding.swift
//  MorningBearDataProvider
//
//  Created by Young Bin on 2023/01/23.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift

protocol DataProviding {
    associatedtype QueryType: Queryable
    associatedtype ResultType
    
    /// Recommend to be declared as an `enum`
    func fetch(_ model: QueryType) -> Single<ResultType>
}

public protocol Queryable {}
