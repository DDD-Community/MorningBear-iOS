//
//  MyMorningsViewModel.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/17.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import RxSwift

import MorningBearDataProvider
import MorningBearKit

class MyMorningsViewModel<Provider: DataProviding> {
    private let dataProvider: Provider
    private let bag = DisposeBag()
    
    @Bound(
        initValue: []
    ) private(set) var myMornings: [MyMorning]
    
    init(_ dataProvider: Provider = DefaultProvider.shared) {
        self.dataProvider = dataProvider
    }
}

extension MyMorningsViewModel {
    /// 새로운 이미지들 요청
    func fetchNewMorning(sort: MyMorningQuery.Sort = .desc) {
        linkRx(dataProvider.fetch(MyMorningQuery(size: 10, sort: sort)), in: bag) { myMornings in
            self.myMornings.append(contentsOf: myMornings)
        }
    }
}
