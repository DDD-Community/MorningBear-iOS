//
//  CompositeCollectionViewTests.swift
//  MorningBearUITests
//
//  Created by 이영빈 on 2023/02/03.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest

import UIKit
@testable import MorningBearUI

final class CollectionViewBuilderTests: XCTestCase {
    private var testBundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    private var collectionView: UICollectionView!
    private var mockCollectionViewBuilder: CollectionViewBuilder<MockSection, AnyHashable>!

    override func setUpWithError() throws {
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        
        mockCollectionViewBuilder = CollectionViewBuilder(
            base: collectionView,
            sections: [MockSection.first, MockSection.second],
            cellTypes: [MockCollectionViewCell.self, MockOtherCollectionViewCell.self],
            cellProvider: { collectionView, indexPath in
                switch MockSection(rawValue: indexPath.section) {
                case .first:
                    return MockCollectionViewCell.dequeueAndPrepare(
                        from: collectionView, at: indexPath, prepare: MockModel()
                    )
                case .second:
                    return MockOtherCollectionViewCell.dequeueAndPrepare(
                        from: collectionView, at: indexPath, prepare: MockModel()
                    )
                case .none:
                    return UICollectionViewCell()
                }
            },
            layoutSectionProvider: { section, _ in
                CompositionalLayoutProvider().plainLayoutSection(height: 1)
            },
            delegate: self
        )
        
        collectionView = mockCollectionViewBuilder.build()
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {
        collectionView = nil
    }

    func testRegistration() throws {
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
    }
}

extension CollectionViewBuilderTests: UICollectionViewDelegate {}
