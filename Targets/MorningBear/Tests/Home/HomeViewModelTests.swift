//
//  HomeViewModelTests.swift
//  MorningBearTests
//
//  Created by Young Bin on 2023/01/10.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest

import Quick
import Nimble

@testable import MorningBear

final class HomeViewModelSpec: QuickSpec {
    override func spec() {
        describe("HomeViewModel 테스트") {
            var mockLocalStorage: UserDefaults!
            var mockHomeDataProvider: HomeViewDataProvider!
            var viewModel: HomeViewModel!
            
            beforeEach {
                mockLocalStorage = UserDefaults(suiteName: "test home")!
                mockHomeDataProvider = HomeViewDataProvider(mockLocalStorage)
                viewModel = HomeViewModel(mockHomeDataProvider)
            }
            
            afterEach {
                UserDefaults.standard.removeSuite(named: "test home")
                mockHomeDataProvider = nil
                viewModel = nil
            }
            
            describe("저장된 데이터에 따른 recordState 초기화 테스트") {
                afterEach { exampleMetadata in
                    mockHomeDataProvider = nil
                    viewModel = nil
                }
                
                it("stop(startTime = nil) 으로 초기화 되면") {
                    mockHomeDataProvider.persistentMyMorningRecordDate = nil
                    viewModel = HomeViewModel(mockHomeDataProvider)
                    
                    expect(viewModel.isMyMorningRecording).to(equal(.waiting))
                }
                
                it("뷰 모델의 recordState가 recording으로 초기화되면") {
                    let startDate = Date()
                    mockHomeDataProvider.persistentMyMorningRecordDate = startDate
                    viewModel = HomeViewModel(mockHomeDataProvider)
                    
                    if case .recording(let savedStartDate) = viewModel.isMyMorningRecording {
                        expect(savedStartDate).to(beCloseTo(startDate))
                    } else {
                        fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
                    }
                }
            }
            
            describe("기록 시작/중지 테스트") {
                afterEach { exampleMetadata in
                    mockHomeDataProvider = nil
                    viewModel = nil
                }
                
                it("기록 시작") {
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
                
                it("기록 중지") {
                    let startDate = Date()
                    mockHomeDataProvider.persistentMyMorningRecordDate = startDate
                    viewModel = HomeViewModel(mockHomeDataProvider)
                    
                    guard case .recording = viewModel.isMyMorningRecording else {
                        fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
                        return
                    }
                    
                    let savedStartDate = try viewModel.stopRecording()
                    expect(startDate).to(beCloseTo(savedStartDate))
                    
                    guard case .stop = viewModel.isMyMorningRecording else {
                        fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
                        return
                    }
                }
                
                context("기록 시작 시 특정 시작 시간이 주어짐(초기화 X)") {
                    let expectedDate = Date(timeIntervalSince1970: 9999)
                    
                    it("기록 시작") {
                        mockHomeDataProvider.persistentMyMorningRecordDate = nil
                        viewModel = HomeViewModel(mockHomeDataProvider)
                        
                        guard viewModel.isMyMorningRecording == .waiting || viewModel.isMyMorningRecording == .stop else {
                            fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
                            return
                        }
                        
                        viewModel.startRecording(with: expectedDate) // 시간 주어짐
                        
                        guard case .recording(let startDate) = viewModel.isMyMorningRecording else {
                            fail("with unexpected record condition: \(viewModel.isMyMorningRecording)")
                            return
                        }
                        
                        let savedStartDate = try viewModel.stopRecording()
                        expect(startDate).to(beCloseTo(savedStartDate))
                    }
                }
            }
        }
        
    }
}
