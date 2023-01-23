//
//  MyBadgeDataProvider.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/15.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

@_exported import MorningBearData
import MorningBearUI

public struct BadgeStateDataProvider {
    func fetchBadges() -> [Badge] {
        return [
            .init(image: MorningBearUIAsset.Images.streakThree.image, title: "시작이 반", desc: "2023.1.3"),
            .init(image: MorningBearUIAsset.Images.streakTen.image, title: "시작이 반", desc: "2023.1.3"),
            .init(image: MorningBearUIAsset.Images.streakFifty.image, title: "시작이 반", desc: "2023.1.3"),
            .init(image: MorningBearUIAsset.Images.fever.image, title: "시작이 반", desc: "2023.1.3"),
            
            .init(image: MorningBearUIAsset.Images.support.image, title: "시작이 반", desc: "2023.1.3"),
            .init(image: MorningBearUIAsset.Images.fistBump.image, title: "시작이 반", desc: "2023.1.3"),
            .init(image: MorningBearUIAsset.Images.health.image, title: "시작이 반", desc: "2023.1.3"),
            .init(image: MorningBearUIAsset.Images.hobby.image, title: "시작이 반", desc: "2023.1.3"),
            
            .init(image: MorningBearUIAsset.Images.godSeng.image, title: "시작이 반", desc: "2023.1.3"),
            .init(image: MorningBearUIAsset.Images.niceStart.image, title: "시작이 반", desc: "2023.1.3"),
            .init(image: MorningBearUIAsset.Images.stable.image, title: "시작이 반", desc: "2023.1.3"),
            .init(image: MorningBearUIAsset.Images.knowledge.image, title: "시작이 반", desc: "2023.1.3")
        ]
    }
}
