//
//  InitialInfoViewModel.swift
//  MorningBear
//
//  Created by 이건우 on 2023/01/11.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift
import RxRelay

// FIXME: develop에 머지 후 변경된 타겟 상태에 따라 수정될 예정
import MorningBearUI

class InitialInfoViewModel {
    
    // page view managing values
    var currentIndex: BehaviorRelay<Int>
    var canGoNext: BehaviorRelay<[Bool]>
    var oldIndex: Int = 0
    
    // Wake up
    
    // Activities
    // entity
    let activities: [Activity] = [
        Activity(id: "0", image: MorningBearUIAsset.Images.exercise.image, name: "운동"),
        Activity(id: "1", image: MorningBearUIAsset.Images.study.image, name: "공부"),
        Activity(id: "2", image: MorningBearUIAsset.Images.life.image, name: "생활"),
        Activity(id: "3", image: MorningBearUIAsset.Images.emotion.image, name: "정서"),
        Activity(id: "4", image: MorningBearUIAsset.Images.hobby.image, name: "취미"),
        Activity(id: "5", image: MorningBearUIAsset.Images.etc.image, name: "기타")
    ]
    
    var selectedActivities: [String] = []
    
    func completeInitialStep() {}
    
    init() {
        self.currentIndex = BehaviorRelay(value: 0)
        self.canGoNext = BehaviorRelay(value: [false, false, false, false])
    }
}
