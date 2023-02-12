//
//  MyPageDataSet.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/02/12.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public struct MyPageData: Hashable {
    public typealias PhotoDictionary =  [MorningBearData.Category: [MyMorning]]
    
    public let profile: Profile
    public let favoriteCategories: [Category]
    public var photos: PhotoDictionary
    
    public init(profile: Profile, favoriteCategories: [Category], photos: PhotoDictionary) {
        self.profile = profile
        self.favoriteCategories = favoriteCategories
        self.photos = photos
    }
}
