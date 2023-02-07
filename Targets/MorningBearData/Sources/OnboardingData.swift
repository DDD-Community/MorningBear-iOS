//
//  OnboardingData.swift
//  MorningBear
//
//  Created by 이건우 on 2022/12/15.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

public struct OnboardingData {
    public let image: String
    public let title: String
    public let description: String
    
    public init(image: String, title: String, description: String) {
        self.image = image
        self.title = title
        self.description = description
    }
}
