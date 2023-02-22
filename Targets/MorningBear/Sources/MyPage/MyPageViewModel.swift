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
    
    @Bound private(set) var isNetworking: Bool = false
    
    @Bound private(set) var profile: Profile = Profile(imageURL: URL(string: "www.naver.com")!,
                                                       nickname: "s",
                                                       counts: .init(postCount: 0, supportCount: 0, badgeCount: 0))

    @Bound private(set) var selectedCatagory: Category = .exercies
    @Bound private(set) var categories: [Category] = []
    @Bound private(set) var recentMorning: [MyMorning] = []
    
    private var recentMorningDictionary: [Category: [MyMorning]] = [:]
    
    let categoryOptions = Category.allCases.map { $0.description }
    
    func fetch() {
        isNetworking = true
        
        dataProvider.fetch(MyPageQuery())
            .concurrentSubscribe(
                completionHandler: { mypageData in
                    self.profile = mypageData.profile
                    self.categories = mypageData.favoriteCategories
                    
                    self.recentMorningDictionary = mypageData.photos
                    self.fetchMyMorning(category: self.selectedCatagory)
                },
                disposeHandler: {
                    self.isNetworking = false
                })
            .disposed(by: bag)
    }
    
    func fetchMyMorning(category: Category) {
        selectedCatagory = category
        guard let recentMorning = recentMorningDictionary[category] else {
            return
        }
        
        self.recentMorning = recentMorning
    }
    
    init(dataProvider: DefaultProvider = DefaultProvider.shared) {
        self.dataProvider = dataProvider
        
        fetch()
    }
}
