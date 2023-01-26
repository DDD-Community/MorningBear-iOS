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
import MorningBearKit
import MorningBearStorage
import MorningBearAPI
//
///// 등록 정보를 '만드는' 뮤테이션
/////
///// `RegisterMutation`이랑 헷갈리지 말 것. 얘는 네트워크 요청 안 하는 그냥 툴임
//struct MorningInfoSingleTrait<RemoteStorage: RemoteStoraging>: Mutable {
//    typealias ResultType = (photoLink: String, updateBadges: [Badge])
//
//    private let info: MorningRegistrationInfo
//    private let remoteStorageManager: RemoteStorage
//
//    var singleTrait: Single<ResultType> {
//        return SavePhotoStorageMutation(image: info.image, remoteStorageManager)
//            .singleTrait
//            .map { photoUrl -> PhotoInput in
//                return info.toApolloMuataionType(photoLink: photoUrl)
//            }
//            .map { photoInput in
//                MorningInfoRegisterMutation(photoInput: photoInput).singleTrait
//            }
//            .flatMap { $0 }
//    }
//    
//    init(info: MorningRegistrationInfo, _ remoteStorageManager: RemoteStorage) {
//        self.info = info
//        self.remoteStorageManager = remoteStorageManager
//    }
//}
//
//fileprivate extension MorningRegistrationInfo {
//    func toApolloMuataionType(photoLink: URL) -> PhotoInput {
//        // 서버 요구사항: hhmm으로 변환헤서 줄 거임. 아 귀찮아~
//        let formatter = MorningBearDateFormatter.shortimeFormatter
//        
//        let parsedStartTime = formatter.string(from: self.startTime)
//        let parsedEndTime = formatter.string(from: self.endTime)
//        
//        return PhotoInput(
//            photoLink: .some(photoLink.absoluteString),
//            photoDesc: .some(self.comment),
//            categoryId: .some(self.category),
//            startAt: .some(parsedStartTime),
//            endAt: .some(parsedEndTime)
//        )
//    }
//}
