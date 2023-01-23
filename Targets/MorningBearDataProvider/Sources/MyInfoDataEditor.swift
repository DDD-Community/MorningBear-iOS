//
//  MyInfoDataEditor.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/01/23.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

@_exported import MorningBearData

import UIKit

import RxSwift

import MorningBearUI
import MorningBearAPI
import MorningBearNetwork
import MorningBearStorage

public struct MyInfoDataProvider {
    public init() {}
}

public extension MyInfoDataProvider {
    func request() -> Single<MyInfo> {
        let singleTrait = Network.shared.apollo.rx.fetch(query: MyInfoForHomeQuery())
            .map { data -> MyInfoForHomeQuery.Data.FindMyInfo.ReportInfo in
                guard let data = data.data else {
                    throw DataProviderError.cannotGetResponseFromServer
                }
                
                guard let info = data.findMyInfo?.reportInfo else {
                    throw DataProviderError.invalidPayloadData
                }
                
                return info
            }
            .map { info in
                try info.toNativeType()
            }
        
        return singleTrait
    }
}

fileprivate extension MyInfoForHomeQuery.Data.FindMyInfo.ReportInfo {
    func toNativeType() throws -> MyInfo {
        guard let totalTime, let countSucc else {
            throw DataProviderError.invalidPayloadData
        }
        
        return MyInfo(estimatedTime: totalTime,
                      totalCount: countSucc,
                      badgeCount: "-1")
    }
}
