//
//  HomeSection.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

enum HomeSection {
    case state(State)
    case recentMornings([RecentMorning])
    case badges([Badge])
    case articles([Article])
    
    // FIXME: 아래 모델들 다 나중에 별개 파일로 분리시킬 예정
    struct State {
        let nickname: String
    }
    
    struct RecentMorning {
        let image: UIImage
        let title: String
        let desc: String
    }
    
    struct Badge {
        let image: UIImage
        let title: String
        let desc: String
    }
    
    struct Article {
        let image: UIImage
        let title: String
        let desc: String
    }
}
