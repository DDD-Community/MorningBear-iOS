//
//  MyMorningsViewModel.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/17.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation
import MorningBearUI

class MyMorningsViewModel {
    private let dataProvider: MyMorningDataProvider
    var myMornings: [RecentMorning]
    
    func fetchNewMorning() -> [RecentMorning] {
        let newData = dataProvider.fetch()
        
        myMornings.append(contentsOf: newData)
        return newData
    }
    
    init(_ dataProvider: MyMorningDataProvider = MyMorningDataProvider()) {
        self.dataProvider = dataProvider
        
        self.myMornings = dataProvider.fetch()
    }
}
