//
//  RegisterMorningRequestService.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/18.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import RxSwift

import MorningBearAPI
import MorningBearUI
import MorningBearNetwork

struct RegisterMorningRequestService {
    func request() {
        
    }
}

extension RecentMorning {
    typealias ReturnType = (photoLink: String, updateBadges: [Badge])
    
    func request(_ info: MorningRegistrationInfo) -> Single<ReturnType> {
        let photoInput = info.toApolloMuataionType
        
        let singleTrait = Network.shared.apollo.rx
            .perform(mutation: SaveMyPhotoMutation(input: .some(photoInput)))
            .map { data -> SaveMyPhotoMutation.Data.SaveMyPhoto in
                guard let mutationResult = data.data?.saveMyPhoto else {
                    throw URLError(.cannotDecodeRawData)
                }
                
                return mutationResult
            }
            .map { mutationResult -> ReturnType in
                guard let photoLink = mutationResult.photoLink else {
                    throw URLError(.badURL)
                }
                
                guard var receivedBadges = mutationResult.updatedBadge,
                      receivedBadges.contains(nil)
                else {
                    throw URLError(.cannotDecodeRawData)
                }
                
                let updatedBadges = receivedBadges.compactMap { $0?.toNativeType }

                return (photoLink, updatedBadges)
            }
        
        return singleTrait
    }
}

extension MorningRegistrationInfo {
    var toApolloMuataionType: PhotoInput {
        return PhotoInput(
            photoId: .some("?"),
            photoLink: .some("?"),
            photoDesc: .some(self.comment),
            categoryId: .some("?"),
            startAt: .some(self.startTime.toString()),
            endAt: .some(self.endTime.toString())
        )
    }
}

extension SaveMyPhotoMutation.Data.SaveMyPhoto.UpdatedBadge {
    var toNativeType: Badge {
        // TODO: Get badge id
        Badge(image: MorningBearUIAsset.Images.streakTen.image,
              title: self.badgeTitle ?? "",
              desc: self.badgeDesc ?? "")
    }
}
