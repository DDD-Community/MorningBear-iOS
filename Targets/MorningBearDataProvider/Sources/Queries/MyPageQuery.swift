//
//  MyPageQuery.swift
//  MorningBearDataProvider
//
//  Created by Young Bin on 2023/02/12.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import UIKit
import RxSwift

@_exported import MorningBearData
import MorningBearUI
import MorningBearAPI
import MorningBearNetwork

public struct MyPageQuery  {
    public typealias ResultType = String
    
    public let singleTrait = Network.shared.apollo.rx.fetch(query: GetMyPageDataQuery())
        .map { data -> GetMyPageDataQuery.Data.FindMyInfo in
            guard let data = data.data else {
                throw DataProviderError.cannotGetResponseFromServer
            }
            
            guard let findMyInfo = data.findMyInfo else {
                throw DataProviderError.invalidPayloadData(message: "잘못된 쿼리 응답(\(#function)")
            }
            
            return findMyInfo
        }
        .map { findMyInfo -> MyPageData in
            findMyInfo.toNativeType()
        }
    
    public init() {}
}

extension GetMyPageDataQuery.Data.FindMyInfo: ApolloAdaptable {
    typealias Category = MorningBearData.Category
    
    public func toNativeType() -> MyPageData {
        let profile = Profile(
            image: UIImage(systemName: "person")!,
            nickname: "추가할 것",
            counts: Profile.CountContext(
                postCount: self.reportInfo?.countSucc ?? 0,
                supportCount: self.takenLikeCnt ?? 0,
                badgeCount: self.badgeList?.count ?? 0
            )
        )
        
        let categories: [Category] = (self.categoryList ?? []).compactMap { categorySet -> Category in
            guard let categorySet else {
                return .emotion
            }
            
            guard let stringId = categorySet.categoryId else {
                return .emotion
            }
            
            guard let category = Category.fromId(stringId) else {
                return .emotion
            }
            
            return category
        }
        
        let unwrappedPhotoInfoByCategory = (self.photoInfoByCategory ?? []).compactMap { $0 }
        
        var photos = [Category: [URL]]()
        unwrappedPhotoInfoByCategory.forEach { photoInfoByCategory in
            guard var photoInfos = photoInfoByCategory.photoInfo else {
                return
            }
            
            photoInfos = photoInfos.compactMap { $0 }
            
            photoInfos.forEach { photoInfo in
                guard let link = photoInfo?.photoLink,
                      let url = URL(string: link),
                      let categoryId = photoInfo?.categoryId,
                      let category = Category.fromId(categoryId)
                else {
                    return
                }
                
                photos[category, default: []].append(url)
            }
        }
        
        return MyPageData(profile: profile, favoriteCategories: categories, photos: photos)
    }
}
