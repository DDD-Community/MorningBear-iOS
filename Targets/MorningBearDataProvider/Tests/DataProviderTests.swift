//
//  DataProviderTests.swift
//  MorningBearDataProviderTests
//
//  Created by 이영빈 on 2023/02/15.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest

import RxSwift
import RxBlocking

import MorningBearTestKit
@testable import MorningBearDataProvider

final class DataProviderTests: XCTestCase {
    var mockProvider: DataProviderMock!
    override func setUpWithError() throws {
        self.mockProvider = DataProviderMock()
    }

    override func tearDownWithError() throws {
        mockProvider = nil
    }

    func testFetch() throws {
        let fetchedResult = mockProvider.fetch(MockQuery(expected: expectedString))
        // Default fetch should return defined Single type
        XCTAssertTrue(type(of: fetchedResult) == Single<MockQuery.ResultType>.self)
        
        let result = fetchedResult
            .toBlocking()
            .materialize()
        
        switch result {
        case .completed(elements: let elements):
            let element = try XCTUnwrap(elements.first)
            XCTAssertEqual(expectedString, element)
        case.failed:
            XCTFail()
        }
    }
}

fileprivate let expectedString = "expected_string"

fileprivate struct MockQuery: Queryable {
    let expected: String
    var singleTrait: Single<String> {
        .just(expected)
    }
}
