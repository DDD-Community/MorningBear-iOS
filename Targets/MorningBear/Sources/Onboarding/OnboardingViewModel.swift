//
//  OnboardingViewModel.swift
//  MorningBear
//
//  Created by 이건우 on 2022/12/14.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation
import MorningBearData

class OnboardingViewModel {
    let onboardingData: [OnboardingData] = [
        OnboardingData(image: "1", title: "미라클모닝 후 인증해요", description: "텍스트가 들어가는 영역입니다.\n최대 두 줄까지 가능합니다."),
        OnboardingData(image: "2", title: "동료들을 응원해요", description: "텍스트가 들어가는 영역입니다.\n최대 두 줄까지 가능합니다."),
        OnboardingData(image: "3", title: "뱃지들을 모아봐요", description: "텍스트가 들어가는 영역입니다.\n최대 두 줄까지 가능합니다.")
    ]
}
