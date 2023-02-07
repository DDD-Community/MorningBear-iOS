//
//  MyInfoDataEditor.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/01/23.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation


import UIKit

import RxSwift

@_exported import MorningBearData
import MorningBearUI
import MorningBearAPI
import MorningBearNetwork

public struct MyInfoQuery: Queryable {
    public let singleTrait = Network.shared.apollo.rx.fetch(query: MyInfoForHomeQuery())
        .map { data -> MyInfoForHomeQuery.Data.FindMyInfo in
            guard let data = data.data else {
                throw DataProviderError.cannotGetResponseFromServer
            }
            
            guard let info = data.findMyInfo else {
                throw DataProviderError.invalidPayloadData(message: "나의 상태 정보를 불러올 수 없습니다")
            }
            
            return info
        }
        .map { info in
            try info.toNativeType()
        }
    
    public init() {}
}

fileprivate extension MyInfoForHomeQuery.Data.FindMyInfo {
    func badgeCount() throws -> Int {
        guard let badgeList else {
            throw DataProviderError.invalidPayloadData(message: "배지 정보의 형식이 올바르지 않습니다(501)")
        }
        
        return badgeList.count
    }
    
    func toNativeType() throws -> MyInfo {
        guard let reportInfo else {
            throw DataProviderError.invalidPayloadData(message: "나의 상태 정보 형식이 올바르지 않습니다(501)")
        }
        
        guard let totalTime = reportInfo.totalTime, let successCount = reportInfo.countSucc else {
            throw DataProviderError.invalidPayloadData(message: "나의 상태 정보 형식이 올바르지 않습니다(501)")
        }
        
        let badgeCount = try self.badgeCount()
        
        return MyInfo(estimatedTime: totalTime,
                      totalCount: successCount,
                      badgeCount: badgeCount)
    }
}
