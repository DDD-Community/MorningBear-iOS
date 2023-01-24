//
//  RelayWrapper.swift
//  MorningBearDataProvider
//
//  Created by Young Bin on 2023/01/24.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift
import RxRelay

@propertyWrapper
public struct Bound<Value> {
    private let relay: BehaviorRelay<Value>
    
    public var wrappedValue: Value {
        get {
            self.relay.value
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
