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

// MARK: - Editor body
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
        let mutation = NewMorningMutation(info: info, self.remoteStorageManager)
                
        return self.perform(mutation)
    }
}
