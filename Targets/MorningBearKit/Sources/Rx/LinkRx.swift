//
//  Link.swift
//  MorningBearKit
//
//  Created by Young Bin on 2023/01/28.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift

/// ViewModel에서 `subscribe` 작업 반복되는 것 캡슐화
public func linkRx<Value>(
    _ singleTrait: Single<Value>,
    scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .userInitiated),
    in bag: DisposeBag,
    completionHandler: @escaping (Value) -> Void,
    errorHandler: ((Error) -> Void)? = nil,
    disposeHandler: (() -> Void)? = nil
) {
    singleTrait.subscribe(on: scheduler)
        .retry(2)
        .subscribe(
            onSuccess: { data in
                print(data)
                completionHandler(data)
            },
            onFailure: {
                errorHandler?($0)
                MorningBearLogger.track($0)
            },
            onDisposed: {
                disposeHandler?()
            }
        )
        .disposed(by: bag)
}

public extension PrimitiveSequenceType where Trait == SingleTrait {
    func concurrentSubscribe(
        scheduler: SchedulerType = ConcurrentDispatchQueueScheduler(qos: .userInitiated),
        completionHandler: @escaping (Element) -> Void,
        errorHandler: ((Error) -> Void)? = nil,
        disposeHandler: (() -> Void)? = nil
    ) -> Disposable {
        return self.primitiveSequence
            .subscribe(on: scheduler)
            .retry(2)
            .subscribe(
                onSuccess: { data in
                    print(data)
                    completionHandler(data)
                },
                onFailure: {
                    errorHandler?($0)
                    MorningBearLogger.track($0)
                },
                onDisposed: {
                    disposeHandler?()
                }
            )
    }
}

public extension Observable where Element: Hashable {
    var eraseToAnyHasable: Observable<[AnyHashable]> {
        let erased = self.map {
            return $0 as! [AnyHashable]
        }
        
        return erased
    }
}
