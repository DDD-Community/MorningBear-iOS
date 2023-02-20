//
//  Atomic.swift
//  MorningBearKit
//
//  Created by 이영빈 on 2023/02/20.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

// MARK: - Atomic var
struct Atomic<Value, Lock: Locking> {
    var value: Value { load() }
    
    private var _store: Value!
    private let lock: Lock

    init(_ value: Value, lock: Lock) {
        self.lock = lock
        self.store(newValue: value)
    }
    
    mutating func muatate(_ value: Value) {
        lock.lock()
        defer { lock.unlock() }
        
        store(newValue: value)
    }

    mutating func mutate(_ handler: (Value) -> Value) {
        lock.lock()
        defer { lock.unlock() }
        
        store(newValue: handler(self.value))
    }

    private func load() -> Value {
        return _store
    }

    private mutating func store(newValue: Value) {
        _store = newValue
    }
}

// MARK: - Locks
protocol Locking {
    func lock()
    func unlock()
}

extension Locking {
    func around<T>(_ closure: () -> T) -> T {
        self.lock()
        defer { unlock() }
        return closure()
    }
}

final class RecursiveLock: Locking {
    private let recursiveLock = NSRecursiveLock()
    
    func lock() {
        recursiveLock.lock()
    }
    
    func unlock() {
        recursiveLock.unlock()
    }
}

final class UnfairLock: Locking {
    /// An `os_unfair_lock` wrapper.
    private let unfairLock: os_unfair_lock_t
    
    init() {
        unfairLock = .allocate(capacity: 1)
        unfairLock.initialize(to: os_unfair_lock())
    }
    
    deinit {
        unfairLock.deinitialize(count: 1)
        unfairLock.deallocate()
    }
    
    func lock() {
        os_unfair_lock_lock(unfairLock)
    }
    
    func unlock() {
        os_unfair_lock_unlock(unfairLock)
    }
}

final class NormalLock: Locking {
    /// An `os_unfair_lock` wrapper.
    private let normalLock: NSLock
    
    init() {
        normalLock = NSLock()
    }
    
    func lock() {
        normalLock.lock()
    }
    
    func unlock() {
        normalLock.unlock()
    }
}

