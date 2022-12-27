//
//  HomeSection.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

/// 홈 뷰에서 사용되는 섹션
enum HomeSection {
    /// 현재 상태(누적 시간 등)
    case state(State)
    /// 나의 최근 미라클 모닝
    case recentMornings([RecentMorning])
    /// 나의 배지
    case badges([Badge])
    /// 읽을만한 글
    case articles([Article])
}
