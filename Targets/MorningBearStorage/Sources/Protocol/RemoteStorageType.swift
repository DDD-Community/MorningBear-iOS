//
//  RemoteStorageType.swift
//  MorningBearStorage
//
//  Created by Young Bin on 2023/01/21.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift

protocol RemoteStorageType {
    associatedtype Storage: StorageType

    var remoteStorageService: Storage { get }
    func saveImage(_ image: UIImage) -> Single<URL>
    func loadImage(_ url: URL) -> Single<UIImage>
}

fileprivate struct MockRemoteStorageManager: RemoteStorageType {
    let saveAction: () -> Single<URL>
    let loadAction: () -> Single<UIImage>
    
    let remoteStorageService: MockStorage
    
    func saveImage(_ image: UIImage) -> RxSwift.Single<URL> {
        saveAction()
    }
    
    func loadImage(_ url: URL) -> RxSwift.Single<UIImage> {
        loadAction()
    }
    
    init(saveAction: @escaping () -> Single<URL>, loadAction: @escaping () -> Single<UIImage>, remoteStorageService: MockStorage) {
        self.saveAction = saveAction
        self.loadAction = loadAction
        self.remoteStorageService = remoteStorageService
    }
}

extension RemoteStorageType {
    typealias Mock = MockFunction
}
