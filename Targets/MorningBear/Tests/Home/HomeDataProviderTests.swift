//
//  HomeDataProviderTests.swift
//  MorningBearTests
//
//  Created by 이영빈 on 2023/01/14.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest

import Nimble
@testable import MorningBear

final class HomeDataProviderTests: XCTestCase {
    private var homeDataProvider: HomeViewDataProvider!
    private var mockLocalStorage: UserDefaults!

    override func setUpWithError() throws {
        mockLocalStorage = UserDefaults(suiteName: "homeDataTest")
        homeDataProvider = HomeViewDataProvider(mockLocalStorage)
    }

    override func tearDownWithError() throws {
        mockLocalStorage = nil
        homeDataProvider = nil
    }

    func test__persistentMyMorningRecordDate() throws {
        // Save & fetch normal date case
        var expected: Date? = Date()
        homeDataProvider.persistentMyMorningRecordDate = expected
        
        expect(self.homeDataProvider.persistentMyMorningRecordDate).to(beCloseTo(expected!)) // Nimble
        
        // Delete & fetch the result
        expected = nil
        homeDataProvider.persistentMyMorningRecordDate = expected
        
        expect(self.homeDataProvider.persistentMyMorningRecordDate).to(beNil())
    }
}
