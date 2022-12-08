//
//  LocalStorager.swift
//  MorningBearKit
//
//  Created by 이영빈 on 2022/12/08.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

import RxSwift

struct LocalStorage: StorageType {
    private let storage: FileManager
    
    init(_ storage: FileManager = FileManager.default) {
        self.storage = storage
    }

    func save(data: Data, name: String?) -> Single<URL> {
        let singleTrait = Single<URL>.create { observer in
            do {
                let filePath = try fileURL(with: name)
                try data.write(to: filePath)
                
                observer(.success(filePath))
            } catch let error {
                observer(.failure(error))
            }
            
            return Disposables.create()
        }
        
        return singleTrait
    }
    
    func download(with url: URL) -> Single<Data> {
        let singleTrait = Single<Data>.create { observer in
            do {
                guard storage.fileExists(atPath: url.relativeString) else {
                    throw StorageError.invalidPath
                }
                
                let data = try Data(contentsOf: url)
                observer(.success(data))
            } catch let error {
                observer(.failure(error))
            }
            
            return Disposables.create()
        }
        
        return singleTrait
    }
}

extension LocalStorage {
    var documentDirectory: URL? {
        return try? self.storage.url(for: .documentDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: false)
    }
    
    func fileURL(with name: String?) throws -> URL {
        guard let documentDirectory = documentDirectory else {
            throw StorageError.failToFetchData
        }
        
        let parsedName = name ?? UUID().uuidString
        
        return documentDirectory.appendingPathComponent(parsedName, conformingTo: .data)
    }
}
