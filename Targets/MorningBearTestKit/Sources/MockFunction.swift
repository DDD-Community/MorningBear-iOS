//
//  UIImagePicker+Extension.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/07.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public struct MockFunction<Argument, Result> {
    public typealias Impl = (Argument) -> Result
    
    public var stub: Impl?
    private var calls: [MockFunctionCall<Argument, Result>] = []
    
    public init(_ original: Impl, stubClosuer: Impl? = nil) {
        self.stub = stubClosuer
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

