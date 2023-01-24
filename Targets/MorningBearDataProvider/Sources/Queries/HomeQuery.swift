//
//  HomeQuery.swift
//  MorningBearDataProvider
//
//  Created by Young Bin on 2023/01/24.
//  Copyright © 2023 com.dache. All rights reserved.
//

import RxSwift

@_exported import MorningBearData

public struct HomeQuery<T: DataProviding>: Queryable {
    let dataProvider: T
    
    public var singleTrait: Single<([Badge], MyInfo, [RecentMorning], [Article])> {
        let badges = dataProvider.fetch(BadgeQuery())
        let myInfo = dataProvider.fetch(MyInfoQuery())
        let recentMorning = dataProvider.fetch(MyMorningQuery())
        let articles = dataProvider.fetch(ArticleQuery(size: 10))
        
        return Single.zip(badges, myInfo, recentMorning, articles)
    }
    
    public init(_ dataProvider: T = HomeViewDataProvider()) {
        self.dataProvider = dataProvider
    }
}
