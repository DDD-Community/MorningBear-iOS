//
//  FirebaseStorageMock.swift
//  MorningBear
//
//  Created by Young Bin on 2023/02/14.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation
import UIKit
import RxSwift

import MorningBearTestKit

final class FirebaseStorageManagerMock: RemoteStoraging {
    typealias Storage = FirebaseStorageService
    
    lazy var stubSaveImage = MockFunction(self.saveImage(_:))
    lazy var stubLoadImage = MockFunction(self.loadImage(_:))
    
    func saveImage(_ image: UIImage) -> Single<URL> {
        return stubSaveImage(image)
    }
    
    func loadImage(_ url: URL) -> Single<UIImage> {
        return stubLoadImage(url)
    }
}
