//
//  CustomCellTypeTests.swift
//  MorningBearTests
//
//  Created by Young Bin on 2023/02/02.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest
import UIKit

import Quick
import Nimble

@testable import MorningBearUI

final class CustomCellTypeTest: QuickSpec {
    
}

final class CustomCellTypeTests: XCTestCase {
    private var testBundle: Bundle {
        Bundle(for: type(of: self))
    }
    
    private var collectionView: UICollectionView!
    
    
    override func setUpWithError() throws {
        self.continueAfterFailure = false
        
        let layout = UICollectionViewFlowLayout()
        self.collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    }

    override func tearDownWithError() throws {
        collectionView = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testRegisterDequeueAndPrepare() throws {
        // Test register
        MockCollectionViewCell.register(to: collectionView, bundle: testBundle)
        XCTAssertNotNil(
            collectionView.dequeueReusableCell(
                withReuseIdentifier: MockCollectionViewCell.reuseIdentifier,
                for: IndexPath(row: 0, section: 0)
            )
        )
        
        // Test dequeue and prepare
        XCTAssertNoThrow(
            MockCollectionViewCell.dequeueAndPrepare(
                from: collectionView,
                at: IndexPath(row: 0, section: 0),
                prepare: MockModel()
            )
        )
    }
}
