//
//  DataReceiving.swift
//  MorningBearDataProvider
//
//  Created by Young Bin on 2023/01/24.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public protocol DataReceiving {
    associatedtype Provider: DataProviding
    
    var dataProvider: Provider { get }
}
