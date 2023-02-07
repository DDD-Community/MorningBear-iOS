//
//  CompositeCollectionViewTests.swift
//  MorningBearUITests
//
//  Created by 이영빈 on 2023/02/03.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest

import UIKit
import RxSwift
@testable import MorningBearUI

final class CollectionViewBuilderTests: XCTestCase {
    private var testBundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    private var bag: DisposeBag!
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<MockSection, AnyHashable>!
    
    private var mockSubject = BehaviorSubject<[AnyHashable]>(value: [])
    private var mockCollectionViewBuilder: CollectionViewBuilder<MockSection, AnyHashable>!

    override func setUpWithError() throws {
        self.bag = DisposeBag()
        
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        mockCollectionViewBuilder = CollectionViewBuilder(
            base: collectionView,
            sections: [MockSection.first, MockSection.second],
            cellTypes: [MockCollectionViewCell.self, MockOtherCollectionViewCell.self],
            cellProvider: { collectionView, indexPath, newItem in
                switch MockSection(rawValue: indexPath.section) {
                case .first:
                    return MockCollectionViewCell.dequeueAndPrepare(
                        from: collectionView, at: indexPath, prepare: newItem as! MockModel
                    )
                case .second:
                    return MockOtherCollectionViewCell.dequeueAndPrepare(
                        from: collectionView, at: indexPath, prepare: newItem as! MockModel
                    )
                case .none:
                    return UICollectionViewCell()
                }
            },
            observableProvider: { section in
                .append(self.mockSubject.asObserver())
            },
            layoutSectionProvider: { section, _ in
                CompositionalLayoutProvider().plainLayoutSection(height: 1)
            },
            delegate: self,
            disposeBag: bag
        )
        
        let (collectionView, dataSource) = mockCollectionViewBuilder.build()
        self.collectionView = collectionView
        self.dataSource = dataSource
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        bag = nil
        
        collectionView = nil
        dataSource = nil
        
        mockCollectionViewBuilder = nil
    }

    func testRegistration() throws {
        // Are cells registered correctly?
        XCTAssertNotNil(
            collectionView.dequeueReusableCell(
                withReuseIdentifier: MockCollectionViewCell.reuseIdentifier,
                for: IndexPath(row: 0, section: 0)
            )
        )
        XCTAssertNotNil(
            collectionView.dequeueReusableCell(
                withReuseIdentifier: MockOtherCollectionViewCell.reuseIdentifier,
                for: IndexPath(row: 0, section: 1)
            )
        )
        // Are sections too?
        XCTAssertEqual(dataSource.numberOfSections(in: collectionView), MockSection.allCases.count)
        
        // Is data source too?
        XCTAssertTrue(collectionView.dataSource === dataSource)
    }
    
}

extension CollectionViewBuilderTests: UICollectionViewDelegate {}
