//
//  HomeViewModel.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/28.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

import RxSwift
import RxRelay

import MorningBearUI

class HomeViewModel {
    private let dataProvider: HomeViewDataProvider
    private let bag = DisposeBag()
    
    var state: State?
    var recentMorningList: [RecentMorning]
    var badgeList: [Badge]
    var articleList: [Article]

    var elapsedRecordingTime = BehaviorSubject<String>(value: "")
    
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
        
        if case .recording = isMyMorningRecording {
            elapsedRecordingTimeObservable
                .bind(to: elapsedRecordingTime)
                .disposed(by: bag)
        }
    }
}

extension HomeViewModel {
    var elapsedRecordingTimeObservable: Observable<String> {
        let timer = Observable<Int>
            .interval(.seconds(1), scheduler: SerialDispatchQueueScheduler(qos: .background))
        
        let stringObservable = timer.withUnretained(self)
            .map { (weakSelf, elapsedTime) -> String in
                let timeString: String
                if case .recording(startDate: let startDate) = weakSelf.isMyMorningRecording {
                    timeString = String(Date().timeIntervalSince(startDate))
                } else {
                    throw HomeError.recordRequestedWhileIdle
                }
                
                return timeString
            }
            
        return stringObservable
    }
}

private extension HomeViewModel {
    enum HomeError: LocalizedError {
        case recordRequestedWhileIdle
    }
}

enum MyMorningRecordingState {
    case recording(startDate: Date)
    case idle
}
