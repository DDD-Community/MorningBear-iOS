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

class MyPageViewModel {
    typealias Category = MorningBearDataProvider.Category
    
    private let dataProvider: DefaultProvider
    private let bag = DisposeBag()
    
    @Bound private(set) var profile: Profile = Profile(imageURL: URL(string: "www.naver.com")!,
                                                       nickname: "s",
                                                       counts: .init(postCount: 0, supportCount: 0, badgeCount: 0))
    @Bound private(set) var categories: [Category] = []
    @Bound private(set) var recentMorning: [MyMorning] = []
    
    let categoryOptions = Category.allCases.map { $0.description }
    
    func fetch() {
        dataProvider.fetch(MyPageQuery())
            .concurrentSubscribe { mypageData in
                self.profile = mypageData.profile
                self.categories = mypageData.favoriteCategories
                
                if let morningData = mypageData.photos[Category.exercies] {
                    self.recentMorning = morningData
                }
            }
            .disposed(by: bag)
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
