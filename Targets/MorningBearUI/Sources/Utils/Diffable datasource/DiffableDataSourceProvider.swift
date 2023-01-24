//
//  DiffableDataSourceProvider.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/17.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public protocol DiffableDataSourcing {
    associatedtype Section: Hashable
    associatedtype Model: Hashable
    
    var collectionView: UICollectionView! { get }
    var diffableDataSource: UICollectionViewDiffableDataSource<Section, Model>! { get set }
    
    /// 데이터 소스 여기서 만들고 계속 써먹으면 된다
    func configureDiffableDataSource(with collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<Section, Model>
    
    /// 데이터소스랑 `RxObservable` 연결할 때 쓰면 된다
    func bindDataSourceWithObservable()
    
    /// Optional method
    ///
    /// 헤더나 푸터 더할 떄 쓰면 된다
    func addSupplementaryView<Section, Model>(_ diffableDataSource: UICollectionViewDiffableDataSource<Section, Model>)
}

extension DiffableDataSourcing {
    public typealias Handler = (_ collectionView: UICollectionView, _ indexPath: IndexPath, _ model:Model) -> UICollectionViewCell
    
    public func makeDiffableDataSource(with collectionView: UICollectionView, _ prepareAction: @escaping Handler) -> UICollectionViewDiffableDataSource<Section, Model> {
        let datasource = UICollectionViewDiffableDataSource<Section, Model>(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell in
            
            return prepareAction(collectionView, indexPath, model)
        }
        
        return datasource
    }
    
    /// Optional method
    public func addSupplementaryView<Section, Model>(_ diffableDataSource: UICollectionViewDiffableDataSource<Section, Model>) {}
}

public extension UICollectionViewDiffableDataSource {
    /// 섹션이 여러개일 경우 순서가 틀어지는 문제가 있음. 그러므로 미리 섹션을 순서대로 등록하는 작업을 거쳐야 함
    func initDataSource(allSection: [SectionIdentifierType]) {
        var snapshot = self.snapshot()
        for section in allSection {
            snapshot.appendSections([section])
        }
        
        self.apply(snapshot)
    }
    
    func updateDataSource(in section: SectionIdentifierType, with newData: [ItemIdentifierType], animate: Bool = true) {
        var snapshot = self.snapshot()
        
        guard !snapshot.sectionIdentifiers.isEmpty else {
            fatalError("먼저 initDataSource하고 사용할 것!")
        }
        
        snapshot.appendItems(newData, toSection: section)
        self.apply(snapshot, animatingDifferences: animate)
    }
}
