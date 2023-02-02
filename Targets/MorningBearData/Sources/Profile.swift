//
//  Profile.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/02/01.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public struct Profile: Hashable {
    public let image: UIImage
    public let nickname: String
    public let postCount: Int
    public let supportCount: Int
    public let badgeCount: Int
    
    public init(image: UIImage, nickname: String, postCount: Int, supportCount: Int, badgeCount: Int) {
        self.image = image
        self.nickname = nickname
        self.postCount = postCount
        self.supportCount = supportCount
        self.badgeCount = badgeCount
    }
}
