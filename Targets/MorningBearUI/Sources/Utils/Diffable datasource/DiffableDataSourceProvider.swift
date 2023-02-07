//
//  DiffableDataSourceProvider.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/17.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// `DiffableDataSource` 구현을 도와주는 프로토콜
public protocol DiffableDataSourcing {
    associatedtype Section: Hashable
    associatedtype Model: Hashable
    
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Model>
    
    var collectionView: UICollectionView! { get }
    var diffableDataSource: DiffableDataSource! { get set }
    
    /// 데이터 소스 이 안에서 `makeDiffableDataSource`로  만들고 써먹으면 된다
    func makeDiffableDataSource(with collectionView: UICollectionView) -> DiffableDataSource
    
    /// 데이터소스랑 `RxObservable` 연결할 때 쓰면 된다
    func bindDataSourceWithObservable(_ dataSource: DiffableDataSource)

    /// Optional method
    ///
    /// 헤더나 푸터 더할 떄 쓰면 된다
    func addSupplementaryView(_ diffableDataSource: DiffableDataSource)
}

// MARK: - Extension for the protocol
extension DiffableDataSourcing {
    public typealias Handler = (_ collectionView: UICollectionView, _ indexPath: IndexPath, _ model:Model) -> UICollectionViewCell
    public func configureDiffableDataSource(
        with collectionView: UICollectionView,
        prepareAction: @escaping Handler
    ) -> DiffableDataSource {
        let datasource = DiffableDataSource(collectionView: collectionView) {
            (collectionView, indexPath, model) -> UICollectionViewCell in
            return prepareAction(collectionView, indexPath, model)
        }
        
        return datasource
    }
    
    /// Optional method
    public func addSupplementaryView(_ diffableDataSource: DiffableDataSource) {}
    
    public func commit(_ dataSource: DiffableDataSource) {
        addSupplementaryView(dataSource)
        bindDataSourceWithObservable(dataSource)
    }
}
