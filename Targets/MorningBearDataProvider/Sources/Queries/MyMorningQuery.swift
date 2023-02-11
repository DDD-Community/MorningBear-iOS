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
    let sort: Sort
    let useCache: Bool
    
    public var singleTrait: Single<[MyMorning]> {
        Network.shared.apollo.rx.fetch(
            query: SortedMyMorningPhotoQuery(size: .some(size), sort: .some(String(sort.rawValue))),
            cachePolicy: useCache ? .returnCacheDataElseFetch : .fetchIgnoringCacheData
        )
        .map { data in
            guard let data = data.data else {
                throw DataProviderError.cannotGetResponseFromServer
            }
            
            guard let photoInfo = data.findPhotoByOrderType else {
                throw DataProviderError.invalidPayloadData(message: "나의 미라클 모닝 사진 정보를 불러올 수 없습니다")
            }
            
            let mappedInfo = photoInfo.compactMap({ $0?.toNativeType })
            
            guard photoInfo.count == mappedInfo.count else {
                throw DataProviderError.invalidPayloadData(message: "나의 미라클 모닝 사진 정보가 올바르지 않습니다")
            }
            
            return mappedInfo
        }
        .retry(2)
    }
    
    public init(size: Int = 4, sort: Sort = .desc, useCache: Bool = false) {
        self.size = size
        self.sort = sort
        self.useCache = useCache
    }
    
    public enum Sort: Int, Equatable {
        case asc = 1
        case desc = 2
    }
}

fileprivate extension SortedMyMorningPhotoQuery.Data.FindPhotoByOrderType {
    var toNativeType: MyMorning {
        
        return MyMorning(id: self.photoId ?? UUID().uuidString,
                         imageURL: URL(string: self.photoLink ?? ""))
    }
}
