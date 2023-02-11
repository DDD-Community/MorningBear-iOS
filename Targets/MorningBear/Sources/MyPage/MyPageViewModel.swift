//
//  MyMorningViewModel.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/02/01.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

import MorningBearUI
import MorningBearDataProvider
import MorningBearKit

// FIXME: remove this
import MorningBearData

class MyPageViewModel {
    private let dataProvider: DefaultProvider
    private let bag = DisposeBag()
    
    @Bound private(set) var recentMorning: [MyMorning] = []
    
    let profile = Profile(
        image: MorningBearUIAsset.Images.streakThree.image,
        nickname: "sss",
        counts: Profile.CountContext(postCount: 1, supportCount: 2, badgeCount: 3)
    )
    
    let category = Category.emotion
    
    let themes = Category.allCases.map { $0.description }
    
    func fetch() {
        fetchMyMorning()
        
    }
    
    func fetchMyMorning() {
        dataProvider.fetch(MyMorningQuery(size: 20, sort: .desc, useCache: true))
            .concurrentSubscribe(completionHandler: { mornings in
                self.recentMorning = mornings
            })
            .disposed(by: bag)
    }
    
    init(dataProvider: DefaultProvider = DefaultProvider.shared) {
        self.dataProvider = dataProvider
        
        fetch()
    }
}
