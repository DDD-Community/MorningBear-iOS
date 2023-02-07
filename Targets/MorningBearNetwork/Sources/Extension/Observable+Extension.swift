//
//  Observable+Extension.swift
//  MorningBearKit
//
//  Created by Young Bin on 2022/11/29.
//  Copyright © 2022 com.dache. All rights reserved.
//

import RxSwift

extension ObservableType {
    /// Result를 반환하는 클로저를 RxSwift의 `Observable`로 변환시켜주는 래퍼함수
    ///
    /// - returns: Observable<Element>
    static func createFromResultCallback<E: Error>(_ closure: @escaping (@escaping (Result<Element, E>) -> Void) -> ()) -> Observable<Element> {
        return Observable.create { observer in
            closure { result in
                switch result {
                case .success(let value):
                    observer.onNext(value)
                    observer.onCompleted()
                case .failure(let error):
                    print(error)
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
