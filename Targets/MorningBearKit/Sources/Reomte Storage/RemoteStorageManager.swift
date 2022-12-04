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
    private let bag = DisposeBag()
    
    private let networkQueue = SerialDispatchQueueScheduler.init(qos: .userInitiated)
    
    func saveImage(_ image: UIImage) throws {
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            throw StorageError.invalidImage
        }
        
        remoteStorageService.save(data: data)
            .subscribe(on: networkQueue)
            .subscribe(
                onSuccess: { url in
                    print(url)
                },
                onFailure: { error in
                    print(error)
                }
            )
            .disposed(by: bag)
    }
    
    func loadImage() throws -> UIImage {
        let data = remoteStorageService.load()
        
        guard let image = UIImage(data: data) else {
            throw StorageError.invalidData
        }
        
        return image
    }
    
    init(remoteStorageService: Storage = FirebaseStorageService()) {
        self.remoteStorageService = remoteStorageService
    }
}

