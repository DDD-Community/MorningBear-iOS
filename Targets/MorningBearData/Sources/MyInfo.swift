//
//  User.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/01/23.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public struct MyInfo: Hashable {
    public let estimatedTime: Int
    public let totalCount: Int
    public let badgeCount: String
    
    public init(estimatedTime: Int = 0,
                totalCount: Int = 0,
                badgeCount: String = "") {
        self.estimatedTime = estimatedTime
        self.totalCount = totalCount
        self.badgeCount = badgeCount
    }
}
