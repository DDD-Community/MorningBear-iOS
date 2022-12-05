//
//  RemoteStorageManager.swift
//  MorningBear
//
//  Created by Young Bin on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import RxSwift

public struct RemoteStorageManager<Storage> where Storage: RemoteStorageService {
    private let remoteStorageService: Storage
    
    func saveImage(_ image: UIImage) -> Single<URL> {
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            return Single.error(StorageError.invalidImage)
        }
        
        return remoteStorageService.save(data: data)
    }
    
    func loadImage() -> Single<UIImage> {
        let data = remoteStorageService.load()
        
        guard let image = UIImage(data: data) else {
            return Single.error(StorageError.invalidData)
        }
        
        return Single.just(image)
    }
    
    init(remoteStorageService: Storage = FirebaseStorageService()) {
        self.remoteStorageService = remoteStorageService
    }
}

