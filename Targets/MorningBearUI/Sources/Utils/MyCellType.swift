//
//  MyCellType.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/31.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public protocol CustomCellType {
    static var filename: String { get }
    static var reuseIdentifier: String { get }
}

public extension CustomCellType {
    static func register(to collectionView: UICollectionView, bundle: Bundle) {
        let cellNib = UINib(nibName: Self.filename, bundle: bundle)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Self.reuseIdentifier)
    }
}
