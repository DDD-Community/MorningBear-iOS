//
//  Mock.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import RxSwift

@_exported import MorningBearData
import MorningBearKit

public struct HomeViewDataProvider: DataProviding {
    private let localStorage: UserDefaults
    
    public init(localStorage: UserDefaults = .standard) {
        self.localStorage = localStorage
    }
}

public extension HomeViewDataProvider {
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
