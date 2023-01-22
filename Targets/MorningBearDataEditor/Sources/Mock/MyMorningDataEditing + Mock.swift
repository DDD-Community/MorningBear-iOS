//
//  MyMorningDataEditing + Mock.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/22.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift

extension MyMorningDataEditing {
    typealias Mock = MockMyMorningDataEditor
}

final class MockMyMorningDataEditor: MyMorningDataEditing {
    lazy var requestMock = MockFunction(request)
    
    public func request(_ data: MorningRegistrationInfo) -> Single<(photoLink: String, updateBadges: [Badge])> {
        requestMock(data)
    }
}


public struct MockFunction<Argument, Result> {
    public typealias Impl = (Argument) -> Result
    
    public var stub: Impl?
    private var calls: [MockFunctionCall<Argument, Result>]
    
    public init(_ original: Impl) {
        self.calls = []
    }
    
    public mutating func callAsFunction(_ argument: Argument) -> Result {
        guard let stub else {
            fatalError("Implementation has not been given")
        }
        
        let result = stub(argument)
        calls.append(MockFunctionCall(argument: argument, result: result))
        
        return result
    }
}

public struct MockFunctionCall<Argument, Result> {
    public let argument: Argument
    public let result: Result
}
