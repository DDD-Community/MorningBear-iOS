//
//  DataEditor.swift
//  MorningBearDataEditor
//
//  Created by Young Bin on 2023/01/22.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift

public protocol DataEditing {
    associatedtype InputType
    associatedtype ReturnType

    func request(_ data: InputType) -> Single<ReturnType>
}
