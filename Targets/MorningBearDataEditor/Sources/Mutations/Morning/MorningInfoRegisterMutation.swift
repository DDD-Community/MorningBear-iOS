//
//  MyMorningDataMutation.swift
//  MorningBearDataEditor
//
//  Created by Young Bin on 2023/01/25.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import RxSwift

@_exported import MorningBearData
import MorningBearAPI
import MorningBearNetwork
import MorningBearUI

public struct MorningInfoRegisterMutation: Mutable {
    public typealias ResultType = (photoLink: String, updateBadges: [Badge])
    
    private let photoInput: PhotoInput
    
    public var singleTrait: Single<ResultType> {
        Network.shared.apollo.rx
            .perform(mutation: SaveMyPhotoMutation(input: .some(photoInput)))
            .map { data -> SaveMyPhotoMutation.Data.SaveMyPhoto in
                guard let mutationResult = data.data else {
                    throw DataEditorError.cannotGetResponseFromServer
                }
                
                guard let valueInResult = mutationResult.saveMyPhoto else {
                    throw DataEditorError.emptyResponse
                }
                
                return valueInResult
            }
            .map { mutationResult -> ResultType in
                guard let photoLink = mutationResult.photoLink else {
                    throw DataEditorError.invalidPayloadData(message: "사진 링크 정보를 파싱할 수 없음")
                }
                
                guard let receivedBadges = mutationResult.updatedBadge,
                      receivedBadges.contains(nil) == false
                else {
                    throw DataEditorError.invalidPayloadData(message: "배지 정보를 파싱할 수 없음")
                }
                
                let updatedBadges = receivedBadges.compactMap { $0?.toNativeType }
                
                return (photoLink, updatedBadges)
            }
    }
    
    public init(photoInput: PhotoInput) {
        self.photoInput = photoInput
    }
}

fileprivate extension SaveMyPhotoMutation.Data.SaveMyPhoto.UpdatedBadge {
    var toNativeType: Badge {
        // TODO: Get badge id
        Badge(image: MorningBearUIAsset.Images.streakTen.image,
              title: self.badgeTitle ?? "",
              desc: self.badgeDesc ?? "")
    }
}
