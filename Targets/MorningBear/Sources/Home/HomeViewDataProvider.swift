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
    
    func state() -> State {
        let data = State(nickname: "Mock Nickname")
        return data
    }
    
    func recentMorning() -> [RecentMorning] {
        let data: [RecentMorning] = [
            .init(image: UIColor.random.image(), title: "concept아이템(title1)", desc: "concept아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "concept아이템(title2)", desc: "concept아이템(desc2)"),
            .init(image: UIColor.random.image(), title: "concept아이템(title3)", desc: "concept아이템(desc3)"),
            .init(image: UIColor.random.image(), title: "concept아이템(title4)", desc: "concept아이템(desc4)"),
            .init(image: UIColor.random.image(), title: "concept아이템(title5)", desc: "concept아이템(desc5)"),
            .init(image: UIColor.random.image(), title: "concept아이템(title6)", desc: "concept아이템(desc6)"),
            .init(image: UIColor.random.image(), title: "concept아이템(title7)", desc: "concept아이템(desc7)"),
            .init(image: UIColor.random.image(), title: "concept아이템(title8)", desc: "concept아이템(desc8)"),
            .init(image: UIColor.random.image(), title: "concept아이템(title9)", desc: "concept아이템(desc9)"),
            .init(image: UIColor.random.image(), title: "concept아이템(title10)", desc: "concept아이템(desc10)"),
        ]
        
        return data
    }
    
    func badges() -> [Badge] {
        let data: [Badge] = [
            .init(image: UIColor.random.image(), title: "music아이템(title1)", desc: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title2)", desc: "music아이템(desc2)"),
            .init(image: UIColor.random.image(), title: "music아이템(title3)", desc: "music아이템(desc3)"),
            .init(image: UIColor.random.image(), title: "music아이템(title4)", desc: "music아이템(desc4)"),
            .init(image: UIColor.random.image(), title: "music아이템(title5)", desc: "music아이템(desc5)"),
            .init(image: UIColor.random.image(), title: "music아이템(title6)", desc: "music아이템(desc6)"),
            .init(image: UIColor.random.image(), title: "music아이템(title7)", desc: "music아이템(desc7)"),
            .init(image: UIColor.random.image(), title: "music아이템(title8)", desc: "music아이템(desc8)"),
            .init(image: UIColor.random.image(), title: "music아이템(title9)", desc: "music아이템(desc9)"),
            .init(image: UIColor.random.image(), title: "music아이템(title10)", desc: "music아이템(desc10)"),
        ]
        
        return data
    }
    
    func articles() -> [Article] {
        let data: [Article] = [
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
            .init(image: UIColor.random.image(), title: "music아이템(title1)", description: "music아이템(desc1)"),
        ]
        
        return data
    }
    
    init(_ localStorage: UserDefaults = .standard) {
        self.localStorage = localStorage
    }
}

extension HomeViewDataProvider {
    private enum HomeViewDataProviderStorageKey {
        case myMorningRecordDate
        
        var key: String {
            switch self {
            case .myMorningRecordDate:
                return "myMorningRecordDate"
            }
        }
    }
    
    var persistentMyMorningRecordDate: Date? {
        get {
            guard let rawDateString = localStorage.string(forKey: HomeViewDataProviderStorageKey.myMorningRecordDate.key) else {
                return nil
            }
            
            let formatter = MorningBearDateFormatter.default
            return formatter.date(from: rawDateString)
        }
        set {
            localStorage.set(newValue, forKey: HomeViewDataProviderStorageKey.myMorningRecordDate.key)
        }
    }
}

/// 임시로 사용하는 샘플 이미지 제너레이터
extension UIColor {
    static var random: UIColor {
        UIColor(
            red: CGFloat(drand48()),
            green: CGFloat(drand48()),
            blue: CGFloat(drand48()),
            alpha: 1.0
        )
    }

    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
