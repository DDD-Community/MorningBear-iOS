//
//  RemoteStorageTests.swift
//  MorningBearKitTests
//
//  Created by Young Bin on 2022/12/05.
//  Copyright © 2022 com.dache. All rights reserved.
//

import XCTest
@testable import MorningBearKit

import RxSwift

final class LocalStorageTests: XCTestCase {
    private var storageManager: LocalStorageManager<ValidInstance, MockLocalStorager>!
    private var bag: DisposeBag!
    
    
    override func setUpWithError() throws {
        let mockStorager = MockLocalStorager()
        self.storageManager = LocalStorageManager(mockStorager)
        
        self.bag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        self.bag = DisposeBag()
    }
    
    func test__save() throws {
        let expectation = XCTestExpectation(description: "Test save image success")
        
        storageManager.save(validInstance, name: "test")
            .subscribe (
                onSuccess: { url in
                    print(url)
                    expectation.fulfill()
                }, onFailure: { error in
                    XCTFail("Error happend: \(error)")
                }
            )
            .disposed(by: bag)
                    
        wait(for: [expectation], timeout: 2)
    }
    
    func test__load_success() throws {
        let expectation = XCTestExpectation(description: "Test load image success")
        
        storageManager.load(path: vaildURL)
            .subscribe (
                onSuccess: { (data: ValidInstance) in
                    expectation.fulfill()
                }, onFailure: { error in
                    XCTFail("Error happend: \(error)")
                }
            )
            .disposed(by: bag)
                    
        wait(for: [expectation], timeout: 2)
    }
    
    func test__load_fail() throws {
        let expectation = XCTestExpectation(description: "Test load image fail")
        
        storageManager.load(path: falseURL)
            .subscribe (
                onSuccess: { (data: ValidInstance) in
                    XCTFail("Test should fail")
                }, onFailure: { error in
                    expectation.fulfill()
                }
            )
            .disposed(by: bag)
                    
        wait(for: [expectation], timeout: 2)
    }
}

// MARK: - Internal tools for testing
fileprivate var vaildURL: URL {
    return URL(string: "www.naver.com")!
}

fileprivate var falseURL: URL {
    return URL(string: "www.google.com")!
}

fileprivate let validData = try? JSONEncoder().encode(validInstance)

fileprivate var validInstance: ValidInstance {
    return ValidInstance()
}

fileprivate var falseInstance: FalseInstance {
    return FalseInstance()
}

fileprivate struct MockLocalStorager: StorageType {
    func save(data: Data, name: String?) -> RxSwift.Single<URL> {
        return Single.just(vaildURL)
    }
    
    func download(with url: URL) -> RxSwift.Single<Data> {
        guard url == vaildURL else {
            return Single.error(StorageError.failToLoadImage)
        }
        guard let data = validData else {
            return Single.error(StorageError.invalidImage)
        }
        
        return Single.just(data)
    }
}

fileprivate struct ValidInstance: Codable {
    var title = "title"
    var message = "message"
}

fileprivate struct FalseInstance: Codable {
    var title = "title"
    var message = "message"
}

