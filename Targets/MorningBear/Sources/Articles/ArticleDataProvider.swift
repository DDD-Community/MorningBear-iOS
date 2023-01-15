//
//  ArticleDataProvider.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/15.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation
import UIKit

import MorningBearUI

struct ArticleDataProvider {
    func articles() -> [Article] {
        let data: [Article] = [
            .init(image: UIColor.random.image(), title: "아티클 제목", description: "아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!아주아주 긴 내용!"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
        ]
        
        return data
    }
}
