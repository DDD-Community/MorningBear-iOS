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

struct FirebaseStorage: StorageType {
    private let storage: Storage
    
    init(_ storage: Storage = Storage.storage()) {
        self.storage = storage
    }
    
    func save(data: Data, name: String? = nil) -> Single<URL> {
        // Create a root reference
        // MARK: child가 생략되면 crash
        let storageRef = storage.reference()
        let fileRef = storageRef.child(name ?? UUID().uuidString)
        
        // Make a Rx disposable
        let singleTrait = Single<URL>.create { observer in
            // Upload the file
            fileRef.putData(data, metadata: nil) { (metadata, error) in
                if let error = error {
                    observer(.failure(error))
                    return
                }
                
                guard metadata != nil else {
                    observer(.failure(StorageError.failToLoadImage))
                    return
                }
                
                // You can also access to download URL after upload.
                fileRef.downloadURL { (url, error) in
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
    
    @available(*, deprecated, message: "Use Kingfisher instead")
    func download(with url: URL) -> Single<Data> {
        // Create a reference to the file you want to download
        let storageRef = storage.reference()
        let fileRef = storageRef.child(url.relativeString)

        // Make a Rx disposable
        let singleTrait = Single<Data>.create { observer in
            // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
            fileRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
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
