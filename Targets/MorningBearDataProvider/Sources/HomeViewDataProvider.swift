//
//  Mock.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import MorningBearUI
import MorningBearKit

/// 해당 섹션에 대한 데이터 리스트를 받아오는 메소드들
///
/// 현재 mock으로 대체했으나 나중에 네트워크 통신 결과로 교체하면 될
class HomeViewDataProvider {
    private let localStorage: UserDefaults
    private let badgeDataProvider = MyBadgeDataProvider() // FIXME: protocolize later
    private let articleDataProvider = ArticleDataProvider() // FIXME: protocolize later
    private let myMorningDataProvider = MyMorningDataProvider()
    
    func state() -> State {
        let data = State(nickname: "니나노", oneLiner: "갓생사는 멋진 사람 되기!")
        return data
    }
    
    func recentMorning() -> [RecentMorning] {
        return myMorningDataProvider.fetch()
    }
    
    func badges() -> [Badge] {
        return badgeDataProvider.fetchBadges()
    }
    
    func articles() -> [Article] {
        return articleDataProvider.articles()
    }
    
    init(_ localStorage: UserDefaults = .standard) {
        self.localStorage = localStorage
    }
}

extension HomeViewDataProvider {
    /// 기기에 저장된 기록 시작시간을 반환/저장
    ///
    /// `timeIntervalSince1970`을 이용해 관리함
    var persistentMyMorningRecordDate: Date? {
        get {
            guard let timeIntervalSince1970 = localStorage.object(
                forKey: HomeViewDataProviderStorageKey.myMorningRecordDate.key
            ) as? Double else {
                return nil
            }
            
            let formattedDate = Date(timeIntervalSince1970: timeIntervalSince1970)
            return formattedDate
        }
        set {
            // 기록이 시작되면 Date(newValue)가 nil이 아닌 값으로 입력됨
            // 기록이 끝나면 nil이 입력되기 때문에 저장 대신 데이터를 지워버림
            if let startDate = newValue {
                let timeintervalSince1970 = startDate.timeIntervalSince1970
                localStorage.set(timeintervalSince1970, forKey: HomeViewDataProviderStorageKey.myMorningRecordDate.key)
            } else {
                localStorage.removeObject(forKey: HomeViewDataProviderStorageKey.myMorningRecordDate.key)
            }
            
        }
    }
}

private extension HomeViewDataProvider {
    enum HomeViewDataProviderStorageKey {
        case myMorningRecordDate
        
        var key: String {
            switch self {
            case .myMorningRecordDate:
                return "myMorningRecordDate"
            }
        }
    }
}
