//
//  RemoteStorageService.swift
//  MorningBearKit
//
//  Created by Young Bin on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation
import RxSwift

import MorningBearTestKit

/// 다양한 종류의 저장소를 추상화해 관리할 수 있게 만든 프로토콜
///
/// 원격 저장소, 로컬 저장소 상관 없이 같은 인터페이스를 따르게 해 관리와 테스트를 편리하게 하기 위함임
///
/// - Warning: 모든 메서드의 리턴은 `RxSwift.Observable`타입으로 전달되는 것에 유의
public protocol StorageType {
    /// 데이터를 해당 스토리지에 저장함
    ///
    /// - Parameters:
    ///     - data:  반드시 인코딩 후 `Data` 타입으로 전달되어야 함
    ///     - name: 옵셔널한 값으로 `Firebase`처럼 이름이 크게 필요하지 않은 경우 생략하고 구현할 수 있음
    func save(data: Data, name: String?) -> Single<URL>
    
    /// URL을 가지고 해당하는 데이터를 다운로드 함
    ///
    /// 로컬 스토리지의 경우에도 URL을 가지고 접근하는 것을 원칙으로 함.
    /// `UserDefault`같이 URL이 필요헚는 저장소를 사용하게 될 경우 메서드를 추가해서 사용할 것
    func download(with url: URL) -> Single<Data>
}

extension StorageType {
    typealias Mock = MockStorage
}

final class MockStorage: StorageType {
    lazy var save = MockFunction(save)
    lazy var download = MockFunction(download)
    
    func save(data: Data, name: String?) -> RxSwift.Single<URL> {
        save((data, name))
    }
    
    func download(with url: URL) -> RxSwift.Single<Data> {
        download(url)
    }
}
