//
//  MyMorningsViewModel.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/17.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import MorningBearDataProvider
import MorningBearKit

class MyMorningsViewModel<Provider: DataProviding> {
    private let dataProvider: Provider
    
    @Bound(
        initValue: []
    ) private(set) var myMornings: [MyMorning]
    
    
    func fetchNewMorning() -> [MyMorning] {
        dataProvider.fetch(MyMorningQuery(size: 10))
        
        return []
    }
    
    init(_ dataProvider: Provider = DefaultProvider.shared) {
        self.dataProvider = dataProvider
    }
}
