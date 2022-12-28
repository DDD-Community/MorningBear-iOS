//
//  HomeSection.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

/// 홈 뷰에서 사용되는 섹션
enum HomeSection: Int, CaseIterable {
    /// 현재 상태(누적 시간 등)
    case state
    /// 나의 최근 미라클 모닝
    case recentMornings
    /// 나의 배지
    case badges
    /// 읽을만한 글
    case articles
}

extension HomeSection {
    static func getSection(index: Int) -> HomeSection? {
        return HomeSection(rawValue: index)
    }
    
    var reuseIdentifier: String {
        switch self {
        case .state:
            return "StateCell"
        case .recentMornings:
            return "RecentMorningCell"
        case .badges:
            return "BadgeCell"
        case .articles:
            return "ArticleCell"
        }
    }
}
