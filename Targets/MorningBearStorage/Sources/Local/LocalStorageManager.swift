//
//  StorageManager.swift
//  MorningBearKit
//
//  Created by 이영빈 on 2022/12/08.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import RxSwift

/// 로컬 저장소를 관리하는데 사용하는 클래스
///
/// 프로토콜 `StorageType`을 따르며 `save`, `load` 메서드를 이용해 로컬 저장소와 상호작용할 수 있음.
/// 관리의 용이성을 위해 가능한 해당 클래스를 통해 로컬 저장소와 상호작용하는 것을 추천함
public struct LocalStorageManager<Instance, Storage> where Instance: Codable, Storage: StorageType {
    private let localStorage: Storage
    private let coderSet: CoderSet
    
    public func save(_ instance: Instance, name: String) -> Single<URL> {
        guard let data = try? coderSet.encoder.encode(instance) else {
            return Single.error(StorageError.invalidImage)
        }
        
        return localStorage.save(data: data, name: name)
    }
    
    public func load(path: URL) -> Single<Instance> {
        let downloadTask = localStorage.download(with: path)
            .map { data in
                // 디코딩 시도 및 에러 체크
                guard let instance = try? coderSet.decoder.decode(Instance.self, from: data) else {
                    throw StorageError.invalidData
                }
                
                return instance
            }
        
        return downloadTask
    }
    
    public init(_ localStorage: Storage?) {
        if let localStorage {
            self.localStorage = localStorage
        } else {
            self.localStorage = LocalStorageService() as! Storage
        }
        self.coderSet = CoderSet()
    }
}

fileprivate struct CoderSet {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
}
