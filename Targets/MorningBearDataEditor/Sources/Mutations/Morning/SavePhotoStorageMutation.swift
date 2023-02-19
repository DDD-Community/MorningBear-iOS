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

struct SavePhotoStorageMutation: Mutable {
    private let remoteStorageManager: AnyFirebaseStorage
    private let image: UIImage
    
    var singleTrait: Single<URL> {
        remoteStorageManager.saveImage(image)
    }
    
    init(image: UIImage, _ remoteStorageManager: AnyFirebaseStorage) {
        self.image = image
        self.remoteStorageManager = remoteStorageManager
    }
}
