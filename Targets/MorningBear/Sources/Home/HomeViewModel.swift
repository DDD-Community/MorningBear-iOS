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
import MorningBearKit

class HomeViewModel {
    private let dataProvider: HomeViewDataProvider
    private var bag = DisposeBag()
    
    var state: State?
    var recentMorningList: [RecentMorning]
    var badgeList: [Badge]
    var articleList: [Article]

    var elapsedTime: BehaviorRelay<String?>
    var isMyMorningRecording: BehaviorRelay<MyMorningRecordingState>
    
    init(_ dataProvider: HomeViewDataProvider = HomeViewDataProvider()) {
        self.dataProvider = dataProvider
        
        self.state = dataProvider.state()
        self.recentMorningList = dataProvider.recentMorning()
        self.badgeList = dataProvider.badges()
        self.articleList = dataProvider.articles()
        
        self.elapsedTime = BehaviorRelay<String?>(value: "00:00:00")
        self.isMyMorningRecording = BehaviorRelay<MyMorningRecordingState>(value: .stop)
        
        configureBindings()
        
        // 리코딩 기록 있으면 녹화 재개
        if case .recording = fetchMyMorningRecordingState {
            startRecording()
        }
    }
}

extension HomeViewModel {
    func startRecording() {
        guard case .stop = self.isMyMorningRecording.value else {
            return
        }
        
        let current = Date()
        
        elapsedTimeStringObservable(startDate: current)
            .bind(to: elapsedTime)
            .disposed(by: bag)
        
        isMyMorningRecording.accept(.recording(startDate: current))
    }
    
    func stopRecording() {
        guard case .recording = self.isMyMorningRecording.value else {
            return
        }
        
        bag = DisposeBag() // reset bindings
        isMyMorningRecording.accept(.stop)
    }
}

private extension HomeViewModel {
    func configureBindings() {
        isMyMorningRecording.withUnretained(self)
            .bind { weakSelf, state in
                // Setter
                if case let .recording(startDate: date) = state {
                    weakSelf.dataProvider.persistentMyMorningRecordDate = date
                } else {
                    weakSelf.elapsedTime.accept("00:00:00")
                    weakSelf.dataProvider.persistentMyMorningRecordDate = nil
                }
            }
            .disposed(by: bag)
    }
    
    var fetchMyMorningRecordingState: MyMorningRecordingState {
        if let savedDate = dataProvider.persistentMyMorningRecordDate {
            return .recording(startDate: savedDate)
        } else {
            return .stop
        }
    }
    
    var timerObservable: Observable<Int> {
        return Observable<Int>.interval(
            .seconds(1), scheduler: SerialDispatchQueueScheduler(qos: .background)
        )
    }
    
    func elapsedTimeStringObservable(startDate: Date) -> Observable<String> {
        let stringObservable = timerObservable.withUnretained(self)
            .map { (weakSelf, elapsedTime) -> String in
                let current = Date()
                let diffComponents = Calendar.current.dateComponents(
                    [.hour, .minute, .second], from: startDate, to: current
                )
                
                let timeString = String(
                    format: "%02d:%02d:%02d", diffComponents.hour ?? 0, diffComponents.minute ?? 0, diffComponents.second ?? 0
                )
                
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
    case stop
}
