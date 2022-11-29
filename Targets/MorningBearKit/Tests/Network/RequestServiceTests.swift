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

@testable import MorningBearKit

final class RequestServiceTests: XCTestCase {
    let mockData = FakeData(name: "test")
    let bag = DisposeBag()
    
    func test__request_get_200() throws {
        let mockProvider = stubProvider(endpointClosure: mBearEndpointClosure(200))
        let expectation = XCTestExpectation(description: "Network")
        
        MBearAPI.login(load: mockData).request(provider: mockProvider)
            .map { response -> FakeData in
                let data = response.data
                
                print(String(data: data, encoding: .utf8) as Any)
                let decoded = try MBearAPI.jsonDecoder.decode(FakeData.self, from: data)
                return decoded
            }
            .subscribe(
                onSuccess: { post in
                    expectation.fulfill()
                }, onFailure: { error in
                    XCTFail("Test get failed: \(error)")
                })
            .disposed(by: bag)
        
        wait(for: [expectation], timeout: 3)
    }
    
    func test__request_get_400() throws {
        let expectation = XCTestExpectation(description: "Network")
        let errorStubProvider = stubProvider(endpointClosure: mBearEndpointClosure(400))
        
        MBearAPI.login(load: mockData).request(provider: errorStubProvider)
            .map { response -> FakeData in
                let data = response.data
                
                print(String(data: data, encoding: .utf8) as Any)
                let decoded = try MBearAPI.jsonDecoder.decode(FakeData.self, from: data)
                return decoded
            }
            .subscribe(
                onSuccess: { post in
                    XCTFail("Test get failed: \(post)")
                }, onFailure: { error in
                    expectation.fulfill()
                })
            .disposed(by: bag)
        
        wait(for: [expectation], timeout: 3)
    }
}

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
