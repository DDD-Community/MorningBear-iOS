//
//  LinkRxTests.swift
//  MorningBearKitTests
//
//  Created by Young Bin on 2023/02/12.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest

import RxSwift
import RxBlocking

@testable import MorningBearKit

final class LinkRxTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testEraseArrayOfHasahble() throws {
        let sampleObservableResult = Observable.of([1, 2, 3])
            .map{ $0.eraseToAnyHasable }
            .toBlocking()
            .materialize()

        switch sampleObservableResult {
        case .completed(elements: let result):
            XCTAssertEqual(result.first?.count, 3)
        case .failed:
            XCTFail()
        }
    }
}
