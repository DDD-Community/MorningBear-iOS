//
//  OnboardingViewModel.swift
//  MorningBear
//
//  Created by 이건우 on 2022/12/14.
//  Copyright © 2022 com.dache. All rights reserved.
//

import MorningBearUI
import MorningBearData

import RxSwift
import RxRelay

class OnboardingViewModel {
    
    var currentIndex: BehaviorRelay<Int>
    let onboardingData: [OnboardingData]
    
    init() {
        self.currentIndex = BehaviorRelay(value: 0)
        self.onboardingData = [
            OnboardingData(image: MorningBearUIAsset.Images.onboarding1.image, title: "미라클모닝 후 인증해요", description: "기상을 인증하고 내가 하고\n미라클 모닝을 기록해요"),
            OnboardingData(image: MorningBearUIAsset.Images.onboarding2.image, title: "동료들을 응원해요", description: "다른 미라클 모닝러들을 만나고\n응원하며 소통해요"),
            OnboardingData(image: MorningBearUIAsset.Images.onboarding3.image, title: "뱃지들을 모아봐요", description: "뱃지들을 모으며 나의 미라클 모닝 활동을\n한눈에 확인해요")
        ]
    }
}
