//
//  NewMorningMutation.swift
//  MorningBearDataEditor
//
//  Created by Young Bin on 2023/01/25.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation
import RxSwift

@_exported import MorningBearData
import MorningBearStorage
import MorningBearAPI

public struct NewMorningMutation<RemoteStorage: RemoteStoraging>: Mutable {
    public typealias ResultType = (photoLink: String, updateBadges: [Badge])

    private let info: MorningRegistrationInfo
    private let remoteStorageManager: RemoteStorage

    public var singleTrait: Single<ResultType> {
        return SavePhotoMutation(image: info.image, remoteStorageManager).singleTrait
            .map { photoUrl -> PhotoInput in
                return info.toApolloMuataionType(photoLink: photoUrl)
            }
            .map { photoInput in
                MyMorningMutation(photoInput: photoInput).singleTrait
            }
            .flatMap { $0 }
    }
    
    public init(info: MorningRegistrationInfo, _ remoteStorageManager: RemoteStorage) {
        self.info = info
        self.remoteStorageManager = remoteStorageManager
    }
}

fileprivate extension MorningRegistrationInfo {
    func toApolloMuataionType(photoLink: URL) -> PhotoInput {
        return PhotoInput(
            photoLink: .some(photoLink.absoluteString),
            photoDesc: .some(self.comment),
            categoryId: .some("0"),
            startAt: .some(self.startTime.toString()),
            endAt: .some(self.endTime.toString())
        )
    }
}
