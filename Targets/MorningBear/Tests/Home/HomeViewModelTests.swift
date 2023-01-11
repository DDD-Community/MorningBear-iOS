//
//  HomeViewModelTests.swift
//  MorningBearTests
//
//  Created by Young Bin on 2023/01/10.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest
@testable import MorningBear

final class HomeViewModelTests: XCTestCase {
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        viewModel = HomeViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }
}

private extension HomeViewModelTests {
    
}
