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

final class RemoteStorageTests: XCTestCase {
    private var storageManager: RemoteStorageManager<MockRemoteStorageService>!
    private var bag: DisposeBag!
    
    
    override func setUpWithError() throws {
        let mockService = MockRemoteStorageService()
        self.storageManager = RemoteStorageManager(mockService)
        
        self.bag = DisposeBag()
    }
    
    override func tearDownWithError() throws {
        self.bag = DisposeBag()
    }
    
    func test__saveImage_sucess() throws {
        let expectation = XCTestExpectation(description: "Test save image success")
        
        storageManager.saveImage(validImage)
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
    
    func test__saveImage_fail() throws {
        let expectation = XCTestExpectation(description: "Test save image fail")
        
        storageManager.saveImage(falseImage)
            .subscribe (
                onSuccess: { url in
                    XCTFail("Test should fail")
                }, onFailure: { error in
                    expectation.fulfill()
                }
            )
            .disposed(by: bag)
                    
        wait(for: [expectation], timeout: 2)
    }
    
    func test__loadImage_success() throws {
        let expectation = XCTestExpectation(description: "Test load image success")
        
        storageManager.loadImage(vaildURL)
            .subscribe (
                onSuccess: { image in
                    expectation.fulfill()
                }, onFailure: { error in
                    XCTFail("Error happend: \(error)")
                }
            )
            .disposed(by: bag)
                    
        wait(for: [expectation], timeout: 2)
    }
    func test__loadImage_fail() throws {
        let expectation = XCTestExpectation(description: "Test load image fail")
        
        storageManager.loadImage(falseURL)
            .subscribe (
                onSuccess: { image in
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

fileprivate var validImage: UIImage {
    return UIImage(systemName: "person")!
}

fileprivate var falseImage: UIImage {
    return UIImage()
}

fileprivate struct MockRemoteStorageService: StoragerType {
    func save(data: Data) -> RxSwift.Single<URL> {
        return Single.just(URL(string:"www.naver.com")!)
    }
    
    func download(with url: URL) -> RxSwift.Single<Data> {
        guard url == vaildURL else {
            return Single.error(StorageError.failToLoadImage)
        }
        guard let data = validImage.jpegData(compressionQuality: 0.7) else {
            return Single.error(StorageError.invalidImage)
        }
        
        return Single.just(data)
    }
}
