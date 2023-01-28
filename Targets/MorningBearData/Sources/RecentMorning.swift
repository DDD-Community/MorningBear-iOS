//
//  RecentMorning.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

/// 나의 미라클 모닝에 사용되는 임시 모델
///
/// 네이밍이에서 recent가 빠지고 `MyMorning`등으로 개명될 가능성 농후함
public struct RecentMorning: Hashable, Identifiable {
    public let id: UUID
    public let imageURL: URL?
    
    public init(id: String, imageURL: URL?) {
        self.id = UUID()
        self.imageURL = imageURL
    }
}
