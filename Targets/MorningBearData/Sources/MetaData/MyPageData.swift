//
//  MyPageDataSet.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/02/12.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public struct MyPageData: Hashable {
    public let profile: Profile
    public let favoriteCategories: [Category]
    public var photos: [MorningBearData.Category: [URL]]
    
    public init(profile: Profile, favoriteCategories: [Category], photos: [MorningBearData.Category : [URL]]) {
        self.profile = profile
        self.favoriteCategories = favoriteCategories
        self.photos = photos
    }
}
