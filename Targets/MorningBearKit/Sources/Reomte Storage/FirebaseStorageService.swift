//
//  FirebaseStorageService.swift
//  MorningBearKit
//
//  Created by Young Bin on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

import FirebaseStorage
import RxSwift

struct FirebaseStorageService: RemoteStorageService {
    private let storage = Storage.storage()
    
    func save(data: Data) -> Single<URL> {
        // Create a root reference
        // MARK: child가 생략되면 crash
        // 왜 안알려줬어 구글아..
        let storageRef = storage.reference().child("test.jpg")
        
        // Make a Rx disposable
        let singleTrait = Single<URL>.create { observer in
            // Upload the file
            storageRef.putData(data, metadata: nil) { (metadata, error) in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                
                guard metadata != nil else {
                    observer(.failure(StorageError.failToLoadImage))
                    return
                }
                
                // You can also access to download URL after upload.
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        observer(.failure(error))
                        return
                    }
                    
                    guard let downloadURL = url else {
                        observer(.failure(StorageError.failToLoadImage))
                        return
                    }
                    
                    observer(.success(downloadURL))
                }
            }
            
            return Disposables.create()
        }
        
        return singleTrait
    }
    
    func download(with url: URL) -> Single<Data> {
        // Create a reference to the file you want to download
        let storageRef = storage.reference()

        // Make a Rx disposable
        let singleTrait = Single<Data>.create { observer in
            
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            storageRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
                if let error = error {
                    observer(.failure(error))
                } else if let data = data {
                    observer(.success(data))
                } else {
                    observer(.failure(StorageError.failToLoadImage))
                }
            }
            
            return Disposables.create()
        }
        
        return singleTrait
    }
}
