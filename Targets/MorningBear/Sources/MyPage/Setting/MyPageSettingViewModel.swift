//
//  MyPageSettingViewModel.swift
//  MorningBear
//
//  Created by Young Bin on 2023/02/07.
//  Copyright © 2023 com.dache. All rights reserved.
//


//FIXME: this
import MorningBearData

import MorningBearUI

class MyPageSettingViewModel {
    let profile = Profile(image: MorningBearUIAsset.Images.streakThree.image, nickname: "ss", postCount: 1, supportCount: 2, badgeCount: 3)

    let settings: [AccessoryConfiguration] = [
        .init(label: "로그아웃", accessory: .disclosureIndicator(), accessoryAction: {}),
        .init(label: "회원탈퇴", accessory: .disclosureIndicator(), accessoryAction: {}),
        .init(label: "문의하기", accessory: .disclosureIndicator(), accessoryAction: {}),
        .init(label: "현재버전", accessory: .label(text: "x.x.x"), accessoryAction: {})
    ]
}
