//
//  RemoteStorageService.swift
//  MorningBearKit
//
//  Created by Young Bin on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation
import RxSwift

public protocol RemoteStorageService {
    func save(data: Data) -> Single<URL>
    func load() -> Data
}
