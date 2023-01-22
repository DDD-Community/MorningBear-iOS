//
//  GraphQLRequestTests.swift
//  MorningBearTests
//
//  Created by 이영빈 on 2022/11/29.
//  Copyright © 2022 com.dache. All rights reserved.
//

import XCTest

import Apollo
import RxSwift

import MorningBearAPI
import MorningBearAPITestMocks

import ApolloTestSupport

@testable import MorningBearNetwork

final class GraphQLRequestTests: XCTestCase {
    let bag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test__apollo_fetch() {
        let expectation = XCTestExpectation(description: "graphQL")

        Network.shared.apollo.fetch(query: FindLoginInfoQuery()) { result in
            switch result {
            case .success(let data):
                print(data.data?.findLoginInfo as Any)
            case .failure(let error):
                print("TEST: Error", error.localizedDescription)
            }

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
}
