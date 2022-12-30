//
//  Badge.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

/// 나의 배지 정보
public struct Badge {
    let image: UIImage
    let title: String
    let desc: String
    
    public init(image: UIImage, title: String, desc: String) {
        self.image = image
        self.title = title
        self.desc = desc
    }
}
