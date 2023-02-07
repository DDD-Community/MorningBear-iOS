//
//  MyBadgeState.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2023/01/01.
//  Copyright © 2023 com.dache. All rights reserved.
//

public struct BadgeState {
    public let nickname: String
    public let badgeCount: Int
    
    public init(nickname: String, badgeCount: Int) {
        self.nickname = nickname
        self.badgeCount = badgeCount
    }
}
