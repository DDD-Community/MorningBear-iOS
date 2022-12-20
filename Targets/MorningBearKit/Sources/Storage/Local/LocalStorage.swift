//
//  LocalStorage.swift
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
                // 이름에 해당하는 경로 가져오기 시도
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
    
    /// URL을 사용해 파일을 다운로드. `FileManager`를 사용합니다.
    ///
    /// - Parameters:
    ///     - url: 파일이 저장되어 있는 경로. 이 클래스의 `fileURL(with name: String)`을 사용해 URL을 얻어올 수는 있으나
    ///     별도의 장소에 파일 경로 혹은 이름을 저장해 관리하는 것을 추천
    /// - Returns:
    ///     - `Single`의 형태로 제공되는 `Data` 시퀀스.
    ///
    func download(with url: URL) -> Single<Data> {
        let singleTrait = Single<Data>.create { observer in
            do {
                // 파일 존재 여부 체크
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
    /// 프로젝트 내에서 사용되는 기본 로컬 스토리지 인스턴스.
    ///
    /// 기본값으로 `FileManager`의 `documentDirectory`를 사용함
    var documentDirectory: URL? {
        return try? self.storage.url(for: .documentDirectory,
                                     in: .userDomainMask,
                                     appropriateFor: nil,
                                     create: false)
    }
    
    /// 파일의 이름을 토대로 URL 경로를 반환하는 메서드
    func fileURL(with name: String?) throws -> URL {
        guard let documentDirectory = documentDirectory else {
            throw StorageError.failToFetchData
        }
        
        let parsedName = name ?? UUID().uuidString
        
        return documentDirectory.appendingPathComponent(parsedName, conformingTo: .data)
    }
}
