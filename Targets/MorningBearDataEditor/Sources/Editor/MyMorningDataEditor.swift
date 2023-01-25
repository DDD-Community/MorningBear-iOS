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
import MorningBearStorage

public protocol MyMorningDataEdit: DataEdit {
    func perform<Mutation: MyMorningMutable>(_ mutation: Mutation) -> Single<Mutation.ResultType>
}

public protocol MyMorningMutable: Mutable {}
extension NewMorningMutation: MyMorningMutable {}

public struct MorningDataEdit<Remote: RemoteStoraging, Storage: StorageType>: MyMorningDataEdit {
    public typealias ResultType = (photoLink: String, updateBadges: [Badge])
    public typealias Firebase = FirebaseStorageService

    private let remoteStorageManager: Remote

    public func perform<Mutation: MyMorningMutable>(_ mutation: Mutation) -> Single<Mutation.ResultType> {
        return mutation.singleTrait
    }
    
    public init(_ remoteStorageManager: Remote = RemoteStorageManager<Firebase>()) {
        self.remoteStorageManager = remoteStorageManager
    }
}

public extension MorningDataEdit where Storage == Firebase {
    func request(info: MorningRegistrationInfo) -> Single<ResultType> {
        let mutation = NewMorningMutation(info: info, self.remoteStorageManager)
        
        return self.perform(mutation)
    }
}
