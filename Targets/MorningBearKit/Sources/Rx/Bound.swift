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
@propertyWrapper
public struct Bound<Value> {
    private let relay: BehaviorRelay<Value>
    
    public var wrappedValue: Value {
        get {
            return self.relay.value
        }
        set {
            self.relay.accept(newValue)
        }
    }
    
    public var projectedValue: Observable<Value> {
        return relay.asObservable()
    }
    
    public init(initValue: Value) {
        self.relay = BehaviorRelay<Value>(value: initValue)
        wrappedValue = initValue
        
        relay.accept(initValue)
    }
}
