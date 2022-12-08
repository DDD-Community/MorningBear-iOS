//
//  RemoteStorageManager.swift
//  MorningBear
//
//  Created by Young Bin on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import RxSwift

public struct RemoteStorageManager<Storage> where Storage: StorageType {
    private let remoteStorageService: Storage
    
    public func saveImage(_ image: UIImage) -> Single<URL> {
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            return Single.error(StorageError.invalidImage)
        }
        
        return remoteStorageService.save(data: data, name: nil)
    }
    
    public func loadImage(_ url: URL) -> Single<UIImage> {
        let downloadTask = remoteStorageService.download(with: url)
            .map { data in
                guard let image = UIImage(data: data) else {
                    throw StorageError.invalidData
                }
                
                return image
            }
        
        return downloadTask
    }
    
    public init(_ remoteStorageService: Storage = FirebaseStorage()) {
        self.remoteStorageService = remoteStorageService
    }
}

