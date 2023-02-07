//
//  MyMorningViewModel.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/02/01.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import UIKit
import MorningBearData

class MyPageViewModel {
    let profile = Profile(image: UIImage(systemName: "person")!,
                          nickname: "sss", postCount: 1, supportCount: 23, badgeCount: 3)
    
    let category = Category.emotion
    let themes = Category.allCases.map { $0.description }
    
    let recentMorning = [
        MyMorning(imageURL: URL(string: "www.naver1.com")!),
        MyMorning(imageURL: URL(string: "www.naver2.com")!),
        MyMorning(imageURL: URL(string: "www.naver3.com")!),
        MyMorning(imageURL: URL(string: "www.naver4.com")!)
    ]
}
