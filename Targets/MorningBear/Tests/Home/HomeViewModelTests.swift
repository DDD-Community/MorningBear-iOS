//
//  HomeViewModelTests.swift
//  MorningBearTests
//
//  Created by Young Bin on 2023/01/10.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest
import Nimble

@testable import MorningBear

final class HomeViewModelTests: XCTestCase {
    var mockLocalStorage: UserDefaults!
    var mockHomeDataProvider: HomeViewDataProvider!
    var viewModel: HomeViewModel!

    override func setUpWithError() throws {
        mockLocalStorage = UserDefaults(suiteName: "test home")!
        mockHomeDataProvider = HomeViewDataProvider(mockLocalStorage)
        viewModel = HomeViewModel(mockHomeDataProvider)
    }
    
    override func tearDownWithError() throws {
        UserDefaults.standard.removeSuite(named: "test home")
        mockHomeDataProvider = nil
        viewModel = nil
    }
    
    func test__morning_recording_flag() throws {
        mockHomeDataProvider.persistentMyMorningRecordDate = nil
        viewModel = HomeViewModel(mockHomeDataProvider)
        
        
        guard viewModel.isMyMorningRecording == .waiting || viewModel.isMyMorningRecording == .stop else {
            fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
            return
        }
        
        mockHomeDataProvider.persistentMyMorningRecordDate = Date()
        viewModel = HomeViewModel(mockHomeDataProvider)
        
        guard case .recording = viewModel.isMyMorningRecording else {
            fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
            return
        }
    }
    
    func test__start_recording() throws {
        mockHomeDataProvider.persistentMyMorningRecordDate = nil
        viewModel = HomeViewModel(mockHomeDataProvider)
        
        guard viewModel.isMyMorningRecording == .waiting || viewModel.isMyMorningRecording == .stop else {
            fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
            return
        }
        
        viewModel.startRecording()
        
        guard case .recording = viewModel.isMyMorningRecording else {
            fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
            return
        }
    }
    
    func test__stop_recording() throws {
        let startDate = Date()
        mockHomeDataProvider.persistentMyMorningRecordDate = startDate
        viewModel = HomeViewModel(mockHomeDataProvider)
        
        guard case .recording = viewModel.isMyMorningRecording else {
            fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
            return
        }
        
        let savedStartDate = try viewModel.stopRecording()
        expect(startDate).to(equal(savedStartDate))
        
        guard case .stop = viewModel.isMyMorningRecording else {
            fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
            return
        }
    }
}

private extension HomeViewModelTests {
    
    
}
