//
//  AtomicTests.swift
//  MorningBearKitTests
//
//  Created by 이영빈 on 2023/02/20.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest

@testable import MorningBearKit

final class AtomicTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testAtomic() throws {
        var mockAtomic = Atomic(0, lock: NormalLock())
        
        let concurrentQueue = DispatchQueue(label: "concurrent.test", attributes: .concurrent)
        XCTAssertEqual(mockAtomic.value, 0)
        var expectations = [XCTestExpectation]()
        
        let `repeat` = 100000
        for _ in 0..<`repeat` {
            let expectation = XCTestExpectation(description: "wait until finishes")
            
            concurrentQueue.async {
                mockAtomic.mutate { value in
                    return value + 1
                }
                expectation.fulfill()
            }
            
            expectations.append(expectation)
        }
        
        wait(for: expectations, timeout: 5)
        XCTAssertEqual(mockAtomic.value, `repeat`)
    }
    
    // MARK: - Performance tests
    func testAtomicPerformance() throws {
        // NSLock case
        let atomic = Atomic(0, lock: NormalLock())
        self.measure {
            repeatAddition(atomic: atomic)
        }
    }
    
    func testUnfairlockAtomic() {
        // os_unfair_lock case
        let atomic = Atomic(0, lock: UnfairLock())
        self.measure {
            repeatAddition(atomic: atomic)
        }
    }
    
    func testRecursivelockAtomic() {
        // recursiveLock case
        let atomic = Atomic(0, lock: RecursiveLock())
        self.measure {
            repeatAddition(atomic: atomic)
        }
    }
    
    private func repeatAddition<Lock: Locking>(atomic: Atomic<Int, Lock>) {
        var atomic = atomic
        let concurrentQueue = DispatchQueue(label: "concurrent.test.\(UUID().uuidString)", attributes: .concurrent)

        var expectations = [XCTestExpectation]()
        
        let `repeat` = 100000
        for _ in 0..<`repeat` {
            let expectation = XCTestExpectation(description: "wait until finishes")
            
            concurrentQueue.async {
                atomic.mutate { value in
                    return value + 1
                }
                expectation.fulfill()
            }
            
            expectations.append(expectation)
        }
        
        wait(for: expectations, timeout: 5)
    }
}
