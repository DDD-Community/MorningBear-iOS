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

public struct MyMorningMutation: Mutable {
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
                    throw DataEditorError.invalidPayloadData
                }
                
                guard let receivedBadges = mutationResult.updatedBadge,
                      receivedBadges.contains(nil)
                else {
                    throw DataEditorError.invalidPayloadData
                }
                
                let updatedBadges = receivedBadges.compactMap { $0?.toNativeType }
                
                return (photoLink, updatedBadges)
            }
    }
    
    public init(photoInput: PhotoInput) {
        self.photoInput = photoInput
    }
}

fileprivate extension MorningRegistrationInfo {
    func toApolloMuataionType(photoLink: URL) -> PhotoInput {
        return PhotoInput(
            photoLink: .some(photoLink.absoluteString),
            photoDesc: .some(self.comment),
            categoryId: .some("C1"),
            startAt: .some(self.startTime.toString()),
            endAt: .some(self.endTime.toString())
        )
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
