//
//  MyMorningDataProvider.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/17.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift

@_exported import MorningBearData

public struct MyMorningQuery: Queryable {
    public let singleTrait: Single<[RecentMorning]> = Observable.of(
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
    ).asSingle()
    
    public init() {}
}
