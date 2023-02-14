//
//  RecentMorning.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

/// 나의 미라클 모닝기록 표시에 사용되는 모델
public struct MyMorning {
    public let id: String
    public let imageURL: URL?
    
    public init(id: String = UUID().uuidString, imageURL: URL?) {
        self.id = id
        self.imageURL = imageURL
    }
}

extension MyMorning: Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
