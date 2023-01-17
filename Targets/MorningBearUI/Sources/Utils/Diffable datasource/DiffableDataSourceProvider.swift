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
}

extension DiffableDataSourcing {
    public typealias Handler = (_ collectionView: UICollectionView, _ indexPath: IndexPath, _ model:Model) -> UICollectionViewCell
    
    public func configureDiffableDataSource(_ prepareAction: @escaping Handler) -> UICollectionViewDiffableDataSource<Section, Model> {
        let datasource = UICollectionViewDiffableDataSource<Section, Model>(collectionView: collectionView) { (collectionView, indexPath, model) -> UICollectionViewCell in
            
            return prepareAction(collectionView, indexPath, model)
        }
        
        return datasource
    }
}

public extension UICollectionViewDiffableDataSource {
    func updateDataSource(in section: SectionIdentifierType, with newData: [ItemIdentifierType]) {
        var snapshot = self.snapshot()
        if snapshot.sectionIdentifiers.isEmpty {
            snapshot.appendSections([section])
        }
        
        snapshot.appendItems(newData)
        
        DispatchQueue.global(qos: .background).async {
            self.apply(snapshot, animatingDifferences: true)
        }
    }
}

protocol DataReceiving {
    associatedtype Model
    
    var sources: [Model] { get set }
    func fetch() -> Model
}
