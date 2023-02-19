//
//  RemoteStorageType.swift
//  MorningBearStorage
//
//  Created by Young Bin on 2023/01/21.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift

public protocol RemoteStoraging<Storage> {
    associatedtype Storage: StorageType

    func saveImage(_ image: UIImage) -> Single<URL>
    func loadImage(_ url: URL) -> Single<UIImage>
}
