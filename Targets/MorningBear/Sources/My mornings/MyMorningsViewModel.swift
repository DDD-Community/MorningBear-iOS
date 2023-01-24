//
//  MyMorningsViewModel.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/17.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import MorningBearDataProvider

class MyMorningsViewModel<Provider: DataProviding> {
    private let dataProvider: Provider
    private(set) var myMornings = [RecentMorning]()
    
    func fetchNewMorning() -> [RecentMorning] {
//        let newData = dataProvider.fetch()
//        dataProvider.fetch(MyMorningQuery())
//        myMornings.append(contentsOf: newData)
        return []
    }
    
    init(_ dataProvider: Provider = DefaultProvider.shared) {
        self.dataProvider = dataProvider
    }
}
