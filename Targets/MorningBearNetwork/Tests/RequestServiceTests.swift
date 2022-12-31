//
//  MBearAPITesets.swift
//  MorningBearKit
//
//  Created by 이영빈 on 2022/11/28.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation
import XCTest

import Moya
import RxSwift

@testable import MorningBearNetwork

// MARK: - Internal testing tools
fileprivate func stubProvider<T>(
    endpointClosure: @escaping EndpointClosure<T>,
    stubClosure: StubClosure<T> = MoyaProvider.immediatelyStub
) -> MoyaProvider<T> where T: TargetType {
    let provider = MoyaProvider<T>(endpointClosure: endpointClosure,
                                   stubClosure: MoyaProvider.immediatelyStub)
    
    return provider
}

fileprivate func mBearEndpointClosure(_ responseCode: Int) -> EndpointClosure<MBearAPI> {
    let customEndpointClosure = { (target: MBearAPI) -> Endpoint in
        return Endpoint(url: URL(target: target).absoluteString,
                        sampleResponseClosure: { .networkResponse(responseCode, target.getSampleData) },
                        method: target.method,
                        task: target.task,
                        httpHeaderFields: target.headers)
    }
    
    return customEndpointClosure
}
