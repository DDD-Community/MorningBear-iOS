//
//  InitialInfoViewModel.swift
//  MorningBear
//
//  Created by 이건우 on 2023/01/11.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift
import RxRelay

/// `InitialInfoViewController`의 4가지의 Input View들이 동시에 해당 viewModel을 바라보며 상태를 관리하기 때문에 singletone으로 생성합니다.
class InitialInfoViewModel {
    
    static let shared = InitialInfoViewModel()
    
    var currentIndex: BehaviorRelay<Int>
    var canGoNext: BehaviorRelay<Bool>
    var oldIndex: Int = 0
    
    func completeInitialStep() {}
    
    private init() {
        self.currentIndex = BehaviorRelay(value: 0)
        self.canGoNext = BehaviorRelay(value: true)
    }
}
