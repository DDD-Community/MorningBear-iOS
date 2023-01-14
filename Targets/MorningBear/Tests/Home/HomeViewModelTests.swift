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
            XCTFail("\(viewModel.isMyMorningRecording)")
            return
        }
        
        mockHomeDataProvider.persistentMyMorningRecordDate = Date()
        viewModel = HomeViewModel(mockHomeDataProvider)
        
        guard case .recording = viewModel.isMyMorningRecording else {
            XCTFail("\(viewModel.isMyMorningRecording)")
            return
        }
    }
    
    func test__start_recording() throws {
        mockHomeDataProvider.persistentMyMorningRecordDate = nil
        viewModel = HomeViewModel(mockHomeDataProvider)
        
        guard viewModel.isMyMorningRecording == .waiting || viewModel.isMyMorningRecording == .stop else {
            XCTFail("\(viewModel.isMyMorningRecording)")
            return
        }
        
        viewModel.startRecording()
        
        guard case .recording = viewModel.isMyMorningRecording else {
            XCTFail()
            return
        }
    }
    
    func test__stop_recording() throws {
        mockHomeDataProvider.persistentMyMorningRecordDate = Date()
        viewModel = HomeViewModel(mockHomeDataProvider)
        
        guard case .recording = viewModel.isMyMorningRecording else {
            XCTFail("\(viewModel.isMyMorningRecording)")
            return
        }
        
        viewModel.stopRecording()
        
        guard case .stop = viewModel.isMyMorningRecording else {
            XCTFail()
            return
        }
    }
}

private extension HomeViewModelTests {
    
    
}
