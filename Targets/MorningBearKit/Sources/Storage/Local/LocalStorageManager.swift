//
//  StorageManager.swift
//  MorningBearKit
//
//  Created by 이영빈 on 2022/12/08.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import RxSwift

public struct LocalStorageManager<Instance, Storager> where Instance: Codable, Storager: StorageType {
    private let localStorager: Storager
    private let coderSet: CoderSet
    
    public func save(_ instance: Instance, name: String) -> Single<URL> {
        guard let data = try? coderSet.encoder.encode(instance) else {
            return Single.error(StorageError.invalidImage)
        }
        
        return localStorager.save(data: data, name: name)
    }
    
    public func load(path: URL) -> Single<Instance> {
        let downloadTask = localStorager.download(with: path)
            .map { data in
                guard let instance = try? coderSet.decoder.decode(Instance.self, from: data) else {
                    throw StorageError.invalidData
                }
                
                return instance
            }
        
        return downloadTask
    }
    
    public init(_ localStorager: Storager = LocalStorage()) {
        self.localStorager = localStorager
        self.coderSet = CoderSet()
    }
}

fileprivate struct CoderSet {
    let encoder = JSONEncoder()
    let decoder = JSONDecoder()
}
