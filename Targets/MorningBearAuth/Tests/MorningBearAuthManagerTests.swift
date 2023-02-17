//
//  MorningBearAuthManagerTests.swift
//  MorningBear
//
//  Created by Young Bin on 2023/02/16.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import XCTest
import RxSwift

import Quick
import Nimble

@testable import MorningBearAuth

final class MorningBearAuthManagerBehaviorTests: QuickSpec {
    var mockStorage: UserDefaults!
    var authManager: MorningBearAuthManager!
    var bag: DisposeBag!
    
    let concurrentStorageName = "test.concurrent"
    
    override func spec() {
        beforeSuite {
            guard let mockStorage = UserDefaults(suiteName: "test") else {
                return
            }
            
            self.mockStorage = mockStorage
        }
        
        afterSuite {
            self.mockStorage = nil
            UserDefaults.standard.removeSuite(named: "test")
        }
        
        describe("Auth manager의 기본동작 테스트") {
            beforeEach {
                self.authManager = MorningBearAuthManager(self.mockStorage)
                self.bag = DisposeBag()
            }
            
            afterEach {
                self.authManager = nil
                self.bag = nil
            }
            
            it("로그인") { [self] in
                let expectation = XCTestExpectation()
                expect(self.authManager.token).to(beNil())
                
                authManager.$isLoggedIn
                    .subscribe {
                        expect($0).to(equal(true))
                        expectation.fulfill()
                    }
                    .disposed(by: bag)
                
                authManager.login(token: "test_token")
                wait(for: [expectation], timeout: 3)
                
                expect(self.authManager.isLoggedIn).to(equal(true))
                expect(self.authManager.token).to(equal("test_token"))
            }
            
            it("로그아웃") { [self] in
                let expectation = XCTestExpectation()
                
                authManager.$isLoggedIn
                    .subscribe {
                        expect($0).to(equal(false))
                        expectation.fulfill()
                    }
                    .disposed(by: bag)
                
                authManager.logout()
                
                wait(for: [expectation], timeout: 3)
                
                expect(self.authManager.isLoggedIn).to(equal(false))
                expect(self.authManager.token).to(beNil())
            }
            
            it("탈퇴") { [self] in
                let expectation = XCTestExpectation()
                
                authManager.$isLoggedIn
                    .subscribe {
                        expect($0).to(equal(false))
                        expectation.fulfill()
                    }
                    .disposed(by: bag)
                
                authManager.withdrawal()
                
                wait(for: [expectation], timeout: 3)
                
                expect(self.authManager.isLoggedIn).to(equal(false))
                expect(self.authManager.token).to(beNil())
            }
            
            it("토큰 게터") { [self] in
                let expectedToken = "test_token"
                let expectation = XCTestExpectation()
                
                // Check clear case
                XCTAssertNil(authManager.token)
                
                authManager.$isLoggedIn
                    .subscribe { onNext in
                        expectation.fulfill()
                    }
                    .disposed(by: bag)
                
                authManager.login(token: expectedToken)
                
                wait(for: [expectation], timeout: 3)
                
                expect(self.authManager.token).to(equal(expectedToken))
            }
        }
    }
}
