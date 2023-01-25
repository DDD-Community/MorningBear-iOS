//
//  SavePhotoMutation.swift
//  MorningBearDataEditor
//
//  Created by Young Bin on 2023/01/25.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation
import UIKit

import RxSwift

@_exported import MorningBearData
import MorningBearStorage

public struct SavePhotoMutation<RemoteStorage: RemoteStoraging>: Mutable {
    private let remoteStorageManager: RemoteStorage
    private let image: UIImage
    
    public var singleTrait: Single<URL> {
        remoteStorageManager.saveImage(image)
    }
    
    public init(image: UIImage, _ remoteStorageManager: RemoteStorage) {
        self.image = image
        self.remoteStorageManager = remoteStorageManager
    }
}
