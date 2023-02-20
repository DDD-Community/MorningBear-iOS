//
//  RelayWrapper.swift
//  MorningBearDataProvider
//
//  Created by Young Bin on 2023/01/24.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import RxSwift
import RxRelay

/// 일일히 `BehaviorRelay`, `Observable` 나눠주는 거 귀찮아서 하나로 묶어버림
///
/// 1차적인 목적은 뷰 컨트롤러에서 relay에 `accept`하는 것 막으려고 relay를 `getter`로부터 숨기는 것
///
/// - warning: `struct`로 선언하면 메모리 접근 에러 발생함
@propertyWrapper
public class Bound<Value> {
    private let lock = NSLock()
    private let relay: BehaviorRelay<Value>
    
    public var wrappedValue: Value {
        get {
            self.lock.lock()
            defer { lock.unlock() }
            
            return self.relay.value
        }
        set {
            self.lock.lock()
            defer { lock.unlock() }
            
            self.relay.accept(newValue)
        }
    }
    
    public var projectedValue: Observable<Value> {
        return relay.asObservable()
    }
    
    public init(initValue: Value) {
        self.relay = BehaviorRelay<Value>(value: initValue)
        wrappedValue = initValue
    }
    
    public convenience init(wrappedValue: Value) {
        self.init(initValue: wrappedValue)
    }
}

@propertyWrapper
public final class HotBound<Value> {
    private let semaphore = NSLock()
    
    private var value: Value {
        didSet {
            self.relay.accept(value)
        }
    }
    private let relay: PublishRelay<Value>
    
    public var wrappedValue: Value {
        get {
//            self.semaphore.lock()
//            defer { semaphore.unlock() }
            
            return self.value
        }
        set {
//            self.semaphore.lock()
//            defer { semaphore.unlock() }
            
            self.value = newValue
        }
    }
    
    public var projectedValue: PublishRelay<Value> {
        return relay
    }
    
    public init(initValue: Value) {
        self.value = initValue
        self.relay = PublishRelay<Value>()
        
        wrappedValue = initValue
    }
    
    public convenience init(wrappedValue: Value) {
        self.init(initValue: wrappedValue)
    }
}
