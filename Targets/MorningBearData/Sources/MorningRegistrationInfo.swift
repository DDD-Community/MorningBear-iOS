//
//  MorningInformation.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/05.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public struct MorningRegistrationInfo {
    public let image: UIImage
    public let category: String
    public let startTime: Date
    public let endTime: Date
    public let comment: String
    
    public init(image: UIImage, category: Category, startTime: Date, endTime: Date, comment: String) {
        self.image = image
        self.category = category.id
        self.startTime = startTime
        self.endTime = endTime
        self.comment = comment
    }
}
