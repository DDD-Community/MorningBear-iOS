//
//  State.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

public struct State {
    public let nickname: String
    public let oneLiner: String
    
    public init(nickname: String, oneLiner: String) {
        self.nickname = nickname
        self.oneLiner = oneLiner
    }
}
