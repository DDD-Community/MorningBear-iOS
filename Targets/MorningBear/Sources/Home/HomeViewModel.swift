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

    var elapsedRecordingTime: BehaviorRelay<String?>
    var isMyMorningRecording: BehaviorRelay<MyMorningRecordingState>
    
    init(_ dataProvider: HomeViewDataProvider = HomeViewDataProvider()) {
        self.dataProvider = dataProvider
        
        self.state = dataProvider.state()
        self.recentMorningList = dataProvider.recentMorning()
        self.badgeList = dataProvider.badges()
        self.articleList = dataProvider.articles()
        
        self.elapsedRecordingTime = BehaviorRelay<String?>(value: nil)
        self.isMyMorningRecording = BehaviorRelay<MyMorningRecordingState>(value: .idle)
        
        configureBindings()
        
        // 리코딩 기록 있으면 녹화 재개
        if case .recording = savedMyMorningRecordingState {
            startRecording()
        }
    }
    
    private func configureBindings() {
        isMyMorningRecording.withUnretained(self)
            .bind { weakSelf, state in
                weakSelf.savedMyMorningRecordingState = state
            }
            .disposed(by: bag)
    }
}

extension HomeViewModel {
    
    func startRecording() {
        elapsedRecordingTimeObservable
            .bind(to: elapsedRecordingTime)
            .disposed(by: bag)
        
        savedMyMorningRecordingState = .recording(startDate: Date())
        isMyMorningRecording.accept(savedMyMorningRecordingState)
    }
    
    func stopRecording() {
        bag = DisposeBag()
        
        savedMyMorningRecordingState = .idle
    }
}

private extension HomeViewModel {
    enum HomeError: LocalizedError {
        case recordRequestedWhileIdle
    }
    
    var savedMyMorningRecordingState: MyMorningRecordingState {
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
    
    var elapsedRecordingTimeObservable: Observable<String> {
        let timer = Observable<Int>
            .interval(.seconds(1), scheduler: SerialDispatchQueueScheduler(qos: .background))
        
        let stringObservable = timer.withUnretained(self)
            .map { (weakSelf, elapsedTime) -> String in
                let timeString: String
                if case .recording(startDate: let startDate) = weakSelf.savedMyMorningRecordingState {
                    let current = Date()
                    let diffComponents = Calendar.current.dateComponents(
                        [.hour, .minute, .second], from: startDate, to: current
                    )

                    timeString = String(format: "%02d:%02d:%02d",
                                        diffComponents.hour ?? 0, diffComponents.minute ?? 0, diffComponents.second ?? 0)
                } else {
                    throw HomeError.recordRequestedWhileIdle
                }
                
                return timeString
            }
            
        return stringObservable
    }
}

enum MyMorningRecordingState {
    case recording(startDate: Date)
    case idle
}
