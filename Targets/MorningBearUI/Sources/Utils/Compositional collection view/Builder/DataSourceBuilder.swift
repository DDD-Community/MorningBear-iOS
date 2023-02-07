//
//  DataSourceBuilder.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2023/02/04.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

// MARK: Datasource builder
struct DiffableDataSourceBuilder<Section, Item>
where Section: Hashable,
      Item: Hashable
{
    typealias DiffableDataSource = UICollectionViewDiffableDataSource<Section, Item>
    typealias CellProvider =  DiffableDataSource.CellProvider
    typealias SupplementaryViewProvider = DiffableDataSource.SupplementaryViewProvider
    
    private let collectionView: UICollectionView
    
    private let sections: [Section]

    private let cellProvider: CellProvider
    private let supplementaryViewProvider: SupplementaryViewProvider?
    
    init(
        collectionView: UICollectionView,
        sections: [Section],
        cellProvider: @escaping CellProvider,
        supplementaryViewProvider: SupplementaryViewProvider? = nil
    ) {
        self.collectionView = collectionView
        
        self.sections = sections
        
        self.cellProvider = cellProvider
        self.supplementaryViewProvider = supplementaryViewProvider
    }
    
    enum DataSourceError: LocalizedError {
        case Section(reason: String)
    }
}

extension DiffableDataSourceBuilder {
    func build() -> DiffableDataSource {
        let dataSource = configureDiffableDataSource(with: collectionView)
        dataSource.initDataSource(allSection: self.sections)
        
        addSupplementaryView(dataSource)
        
        return dataSource
    }
}

private extension DiffableDataSourceBuilder {
    func configureDiffableDataSource(with collectionView: UICollectionView) -> DiffableDataSource {
        let datasource = DiffableDataSource(collectionView: collectionView) {
            (collectionView, indexPath, model) -> UICollectionViewCell in
            guard let cell = cellProvider(collectionView, indexPath, model) else {
                return UICollectionViewCell()
            }
            
            return cell
        }
        
        return datasource
    }
    
    func addSupplementaryView(_ dataSource: DiffableDataSource) {
        guard let supplementaryViewProvider else {
            return
        }
        
        dataSource.supplementaryViewProvider = supplementaryViewProvider
    }
}

// MARK: - Extension for DiffableDataSource
public extension UICollectionViewDiffableDataSource {
    /// 섹션이 여러개일 경우 순서가 틀어지는 문제가 있음. 그러므로 미리 섹션을 순서대로 등록하는 작업을 거쳐야 함
    func initDataSource(allSection: [SectionIdentifierType]) {
        guard !allSection.isEmpty else {
            fatalError("섹션이 초기화되지 않음")
        }
        
        var snapshot = self.snapshot()
        for section in allSection {
            snapshot.appendSections([section])
        }
        
        self.apply(snapshot)
    }
    
    func updateDataSource(
        in section: SectionIdentifierType,
        with newData: [ItemIdentifierType],
        animate: Bool = true,
        snapshot: NSDiffableDataSourceSnapshot<SectionIdentifierType, ItemIdentifierType>? = nil
    ) {
        var snapshot = snapshot ?? self.snapshot()

        guard snapshot.sectionIdentifiers.contains(section) else {
            fatalError("먼저 initDataSource하고 사용할 것!")
        }
        
        snapshot.appendItems(newData, toSection: section)
        self.apply(snapshot, animatingDifferences: animate)
    }
    
    /// 섹션의 아이템을 해당 아이템으로 교체함
    ///
    /// 처음 실행 시 `updateDataSource`와 동일하게 동작하지만 그렇지 않을 경우
    /// 아이템이 뒤에 추가되지 않고 `dataSource`가 가리키고 있는 데이터로 단순 교체됨
    func replaceDataSource(
        in section: SectionIdentifierType,
        to newData: [ItemIdentifierType],
        animate: Bool = true
    ) {
        var snapshot = self.snapshot()
        
        if snapshot.sectionIdentifiers.contains(section), snapshot.numberOfItems(inSection: section) > 0 {
            snapshot.reloadSections([section])
            self.apply(snapshot, animatingDifferences: animate)
        } else {
            updateDataSource(in: section, with: newData)
        }
    }
}
