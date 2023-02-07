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
    
    /// 데이터를 새로 덮어씌울지 페이징할지는 소트 타입이 바뀌는지를 보고 판단
    private var currentSortStatus: MyMorningQuery.Sort = .desc
    
    @Bound(
        initValue: []
    ) private(set) var myMornings: [MyMorning]
    
    init(_ dataProvider: Provider = DefaultProvider.shared) {
        self.dataProvider = dataProvider
    }
}

extension MyMorningsViewModel {
    /// 새로운 이미지들 요청
    func fetchNewMorning(sort: MyMorningQuery.Sort? = nil) {
        let sort = sort ?? self.currentSortStatus
        
        linkRx(
            dataProvider.fetch(MyMorningQuery(size: 10, sort: sort, useCache: true)),
            scheduler: SerialDispatchQueueScheduler(qos: .userInitiated),
            in: bag,
            completionHandler: { myMornings in
                if self.currentSortStatus == sort {
                    self.myMornings.append(contentsOf: myMornings)
                } else {
                    self.myMornings = myMornings
                }
            },
            disposeHandler: {
                self.currentSortStatus = sort
            }
        )
    }
}
