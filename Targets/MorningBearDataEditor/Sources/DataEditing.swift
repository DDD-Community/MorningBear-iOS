//
//  DataEditor.swift
//  MorningBearDataEditor
//
//  Created by Young Bin on 2023/01/22.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift

public protocol DataEditing {
    associatedtype InputType
    associatedtype ReturnType

    func request(_ data: InputType) -> Single<ReturnType>
}

public protocol DataEdit {
    func perform<Mutation: Mutable>(_ model: Mutation) -> Single<Mutation.ResultType>
}

extension DataEdit {
    public func perform<Mutation: Mutable>(_ model: Mutation) -> Single<Void> {
        return model.singleTrait.eraseReturnType()
    }
    
    public func perform<Mutation: Mutable>(_ model: Mutation) -> Single<Mutation.ResultType> {
        return model.singleTrait
    }
}

extension Single {
    func eraseReturnType() -> Single<Void> where Trait == SingleTrait {
        return self.map { _ in }
    }
}

public protocol Mutable {
    associatedtype ResultType
    
    var singleTrait: Single<ResultType> { get }
}
