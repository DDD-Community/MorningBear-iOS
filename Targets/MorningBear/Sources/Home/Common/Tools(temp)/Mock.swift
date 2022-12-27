//
//  Mock.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

/// 테스트 용 목데이터
///
/// 나중에 없애버릴 거임
struct Mock {
    static let dataSource = [
        HomeSection.state(
            .init(nickname: "Mock nickname")
        ),
        .recentMornings(
            [
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
        ),
        .badges(
            [
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
        ),
        .articles(
            [
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
        )
    ]
}

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
