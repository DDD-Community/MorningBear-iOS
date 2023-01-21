//
//  RemoteStorageManager.swift
//  MorningBear
//
//  Created by Young Bin on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import RxSwift

protocol RemoteStorageType {
    associatedtype Storage: StorageType

    var remoteStorageService: Storage { get }
    func saveImage(_ image: UIImage) -> Single<URL>
    func loadImage(_ url: URL) -> Single<UIImage>
}

public struct FirebaseStorageManager: RemoteStorageType {
    typealias Storage = FirebaseStorageService
    
    let remoteStorageService: Storage
    
    public func saveImage(_ image: UIImage) -> Single<URL> {
        // 이미지를 jpeg 데이터로 압축. 압축률 의사결정 필요함.
        guard let data = image.jpegData(compressionQuality: 0.7) else {
            return Single.error(StorageError.invalidImage)
        }
        
        return remoteStorageService.save(data: data, name: nil)
    }
    
    public func loadImage(_ url: URL) -> Single<UIImage> {
        let downloadTask = remoteStorageService.download(with: url)
            .map { data in
                // 이미지로 변환 시도
                guard let image = UIImage(data: data) else {
                    throw StorageError.invalidData
                }
                
                return image
            }
        
        return downloadTask
    }
    
    public init(_ remoteStorageService: some StorageType = FirebaseStorageService()) {
        self.remoteStorageService = remoteStorageService as! FirebaseStorageService
    }
}
