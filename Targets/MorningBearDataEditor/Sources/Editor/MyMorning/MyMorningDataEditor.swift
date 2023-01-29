//
//  MyMorningDataEditor.swift
//  MorningBearDataEditor
//
//  Created by 이영빈 on 2023/01/19.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import RxSwift

@_exported import MorningBearData

import UIKit

import MorningBearUI
import MorningBearAPI
import MorningBearNetwork
import MorningBearKit
import MorningBearStorage

// MARK: - Editor body
/// `MyMorningViewModel`에서 사용하는 데이터 에디터
public struct MyMorningDataEditor: MyMorningDataEditing {
    public typealias ResultType = (photoLink: String, updateBadges: [Badge])
    public typealias Firebase = FirebaseStorageService

    private let remoteStorageManager: RemoteStorageManager<Firebase>

    public func perform<Mutation: MyMorningMutable>(_ mutation: Mutation) -> Single<Mutation.ResultType> {
        return mutation.singleTrait
    }
    
    public init(_ remoteStorageManager: RemoteStorageManager<Firebase> = RemoteStorageManager<Firebase>()) {
        self.remoteStorageManager = remoteStorageManager
    }
}

public extension MyMorningDataEditor {
    func request(info: MorningRegistrationInfo) -> Single<ResultType> {
        let mutation = MorningRegistrationSingleTrait(info: info, self.remoteStorageManager)
                
        return self.perform(mutation)
    }
}

/// 등록 정보를 만든다
///
/// `RegisterMutation`이랑 헷갈리지 말 것. 얘는 네트워크 요청 안 하는 그냥 툴임
fileprivate struct MorningRegistrationSingleTrait<RemoteStorage: RemoteStoraging>: Mutable {
    typealias ResultType = (photoLink: String, updateBadges: [Badge])

    private let info: MorningRegistrationInfo
    private let remoteStorageManager: RemoteStorage

    var singleTrait: Single<ResultType> {
        let trait =  SavePhotoStorageMutation(image: info.image, remoteStorageManager)
            .singleTrait
            .map { photoUrl -> PhotoInput in
                // 일단 파이어베이스에 이미지 저장한 다음에 URL 들고 옴
                info.toApolloMuataionType(photoLink: photoUrl)
            }
            .flatMap { photoInput in
                // 요청객체에 URL 채워넣고 리퀘스트 쏨
                MorningInfoRegisterMutation(photoInput: photoInput).singleTrait
            }
            .retry(2)
        
        return trait
    }
    
    init(info: MorningRegistrationInfo, _ remoteStorageManager: RemoteStorage) {
        self.info = info
        self.remoteStorageManager = remoteStorageManager
    }
}

fileprivate extension MorningRegistrationInfo {
    func toApolloMuataionType(photoLink: URL) -> PhotoInput {
        // 서버 요구사항: hhmm으로 변환헤서 줄 거임. 아 귀찮아~
        let formatter = MorningBearDateFormatter.shortimeFormatter
        
        let parsedStartTime = formatter.string(from: self.startTime)
        let parsedEndTime = formatter.string(from: self.endTime)
        
        return PhotoInput(
            photoLink: .some(photoLink.absoluteString),
            photoDesc: .some(self.comment),
            categoryId: .some(self.category),
            startAt: .some(parsedStartTime),
            endAt: .some(parsedEndTime)
        )
    }
}
