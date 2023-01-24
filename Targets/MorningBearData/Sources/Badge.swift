//
//  Badge.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

/// 나의 배지 정보
///
/// Diffable datasource에 사용하기 위해 `Hashable` 채택
public struct Badge: Hashable {
    public let image: UIImage
    public let title: String
    public let desc: String
    
    public init(image: UIImage, title: String, desc: String) {
        self.image = image
        self.title = title
        self.desc = desc
    }
}
