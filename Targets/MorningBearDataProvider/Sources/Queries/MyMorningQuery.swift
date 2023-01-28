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
import MorningBearNetwork
import MorningBearAPI

public struct MyMorningQuery: Queryable {
    let size: Int
    
    public var singleTrait: Single<[MyMorning]> {
        Network.shared.apollo.rx.fetch(query: GetMyMorningPhotosQuery(photoSize: .some(size)))
            .map { data in
                guard let data = data.data else {
                    throw DataProviderError.cannotGetResponseFromServer
                }
                
                guard let photoInfo = data.findMyInfo?.photoInfo else {
                    throw DataProviderError.invalidPayloadData(message: "나의 미라클 모닝 사진 정보를 불러올 수 없습니다")
                }
                
                let mappedInfo = photoInfo.compactMap({ $0?.toNativeType })
                
                guard photoInfo.count == mappedInfo.count else {
                    throw DataProviderError.invalidPayloadData(message: "나의 미라클 모닝 사진 정보가 올바르지 않습니다")
                }
                
                return mappedInfo
            }
    }
    
    public init() {
        self.size = 4
    }
    
    public init(size: Int) {
        self.size = size
    }
}

fileprivate extension GetMyMorningPhotosQuery.Data.FindMyInfo.PhotoInfo {
    var toNativeType: MyMorning {
        
        return MyMorning(id: self.photoId ?? UUID().uuidString,
                             imageURL: URL(string: self.photoLink ?? ""))
    }
}
