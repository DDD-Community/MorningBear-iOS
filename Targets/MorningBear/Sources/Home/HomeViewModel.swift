//
//  HomeViewModel.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/28.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

import MorningBearUI

class HomeViewModel {
    private let dataProvider: HomeViewDataProvider
    
    var state: State?
    var recentMorningList: [RecentMorning]
    var badgeList: [Badge]
    var articleList: [Article]

    var isMyMorningRecording: MyMorningRecordingState {
        get {
            if let savedDate = dataProvider.persistentMyMorningRecordDate {
                return .recording(startDate: savedDate)
            } else {
                return .idle
            }
        }
        set {
            if case let .recording(startDate: date) = newValue {
                dataProvider.persistentMyMorningRecordDate = date
            } else {
                dataProvider.persistentMyMorningRecordDate = nil
            }
        }
    }
    
    init(_ dataProvider: HomeViewDataProvider = HomeViewDataProvider()) {
        self.dataProvider = dataProvider
        
        self.state = dataProvider.state()
        self.recentMorningList = dataProvider.recentMorning()
        self.badgeList = dataProvider.badges()
        self.articleList = dataProvider.articles()
    }
}

enum MyMorningRecordingState {
    case recording(startDate: Date)
    case idle
}
