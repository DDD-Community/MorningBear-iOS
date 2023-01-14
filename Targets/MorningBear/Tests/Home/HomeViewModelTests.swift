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
        let mockHomeDataProvider = HomeViewDataProvider(UserDefaults(suiteName: "test home")!)
        viewModel = HomeViewModel(mockHomeDataProvider)
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test__start_recording() throws {
        viewModel.startRecording()
    }
}

private extension HomeViewModelTests {
    
    
}
