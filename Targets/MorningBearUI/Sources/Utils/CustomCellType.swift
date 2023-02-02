//
//  MyCellType.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/31.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public protocol CustomCellType: UICollectionViewCell {
    associatedtype ModelType
    
    static var filename: String { get }
    static var reuseIdentifier: String { get }
    func prepare(_ data: ModelType)
}

public extension CustomCellType {
    static func register(to collectionView: UICollectionView, bundle: Bundle?) {
        let cellNib = UINib(nibName: Self.filename, bundle: bundle)
        collectionView.register(cellNib, forCellWithReuseIdentifier: Self.reuseIdentifier)
    }
    
    /// 인스턴스를 어레이 형태로 전달하고 받은 `indexPath`를 기반으로 셀에 넣을 데이터를 결정
    static func dequeueAndPrepare(
        from collectionView: UICollectionView,
        at indexPath: IndexPath,
        sources: [ModelType]
    ) -> UICollectionViewCell {
        self.dequeueAndPrepare(from: collectionView, at: indexPath, prepare: sources[indexPath.row])
    }
    
    /// `dequeue`와 `prepare`를 한 번에 처리하는 메소드
    static func dequeueAndPrepare(
        from collectionView: UICollectionView,
        at indexPath: IndexPath,
        prepare data: ModelType
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: Self.reuseIdentifier, for: indexPath
        ) as! Self
        
        cell.prepare(data)
        return cell
    }
}
