//
//  User.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/01/23.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public struct MyInfo {
    let estimatedTime: Int
    let totalCount: Int
    let badgeCount: String
    
    public init(estimatedTime: Int, totalCount: Int, badgeCount: String) {
        self.estimatedTime = estimatedTime
        self.totalCount = totalCount
        self.badgeCount = badgeCount
    }
}
