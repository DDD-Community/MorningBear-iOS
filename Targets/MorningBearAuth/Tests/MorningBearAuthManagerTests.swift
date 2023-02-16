//
//  MorningBearAuthManagerTests.swift
//  MorningBear
//
//  Created by Young Bin on 2023/02/16.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest
import RxSwift

@testable import MorningBearAuth

final class MorningBearAuthManagerTests: XCTestCase {
    var mockStorage: UserDefaults!
    var authManager: MorningBearAuthManager!
    var bag: DisposeBag!
    
    private let semaphore = DispatchSemaphore(value: 1)
    
    override func setUpWithError() throws {
        guard let mockStorage = UserDefaults(suiteName: "test") else {
            throw URLError(.backgroundSessionWasDisconnected) // Any error
        }
        
        self.mockStorage = mockStorage
        authManager = MorningBearAuthManager(mockStorage)
        bag = DisposeBag()
    }

    override func tearDownWithError() throws {
        authManager = nil
        mockStorage = nil
        UserDefaults.standard.removeSuite(named: "test")
    }

    func testLogin() throws {
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        
        let expectation = XCTestExpectation()
        
        authManager.$isLoggedIn
            .subscribe { onNext in
                XCTAssertEqual(onNext.element, true)
                expectation.fulfill()
            }
            .disposed(by: bag)
        
        authManager.login(token: "test_token")
        
        wait(for: [expectation], timeout: 3)
    }
    
    func testLogout() throws {
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        
        let expectation = XCTestExpectation()
        
        authManager.$isLoggedIn
            .subscribe {
                XCTAssertTrue($0 == false)
                expectation.fulfill()
            }
            .disposed(by: bag)
        
        authManager.logout()
        
        wait(for: [expectation], timeout: 3)
        
        XCTAssertNil(authManager.token)
    }
    
    func testLogWithdrawal() throws {
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        
        let expectation = XCTestExpectation()
        
        authManager.$isLoggedIn
            .subscribe {
                XCTAssertTrue($0 == false)
                expectation.fulfill()
            }
            .disposed(by: bag)
        
        authManager.withdrawal()
        
        wait(for: [expectation], timeout: 3)
        
        XCTAssertNil(authManager.token)
    }
    
    func testTokenGetter() throws {
        semaphore.wait()
        defer {
            semaphore.signal()
        }
        
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
        
        XCTAssertEqual(authManager.token, expectedToken)
    }
    
    func testDataRacingCondition() throws {
        semaphore.wait()
        
        let suiteName = "concurrent_test"
        guard let mockStorage = UserDefaults(suiteName: suiteName) else {
            throw URLError(.backgroundSessionWasDisconnected) // Any error
        }
        self.authManager = MorningBearAuthManager(mockStorage)

        defer {
            UserDefaults.standard.removeSuite(named: suiteName)
            semaphore.signal()
        }
        
        let concurrentQueue = DispatchQueue(label: "concurrentQueue.test", attributes: .concurrent)

        // Run 10 concurrent tasks that increment the shared resource
        let taskCount = 10
        let group = DispatchGroup()

        for _ in 0..<taskCount {
            concurrentQueue.async(group: group) {
                self.authManager.login(token: "test_concurrent")
                self.authManager.logout()
            }
        }

        // Wait for all tasks to complete
        let timeout = DispatchTime.now() + 5
        let result = group.wait(timeout: timeout)
        
        XCTAssertEqual(result, .success)
        XCTAssertEqual(authManager.isLoggedIn, false)
    }
}
