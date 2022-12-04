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
        let storageRef = storage.reference()
        
        let singleTrait = Single<URL>.create { observer in
            // Upload the file
            let uploadTask = storageRef.putData(data, metadata: nil) { (metadata, error) in
                guard metadata != nil else {
                    observer(.failure(StorageError.failToLoadImage))
                    return
                }
                
                // You can also access to download URL after upload.
                storageRef.downloadURL { (url, error) in
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
    
    func load() -> Data {
        return Data()
    }
    
}
