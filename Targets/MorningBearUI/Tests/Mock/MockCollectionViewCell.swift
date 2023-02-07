//
//  MockCollectionViewCell.swift
//  MorningBearUITests
//
//  Created by Young Bin on 2023/02/02.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

@testable import MorningBearUI

enum MockSection: Int, Hashable, CaseIterable {
    case first
    case second
}

class MockCollectionViewCell: UICollectionViewCell, CustomCellType {
    static var bundle = MorningBearUITestsResources.bundle
    static var filename: String = "MockCollectionViewCell"
    static var reuseIdentifier: String = "MockCollectionViewCell"
    
    var name: String?
    
    func prepare(_ data: MockModel) {
        name = data.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}


class MockOtherCollectionViewCell: UICollectionViewCell, CustomCellType {
    static var bundle = MorningBearUITestsResources.bundle
    static var filename: String = "MockCollectionViewCell"
    static var reuseIdentifier: String = "MockOtherCollectionViewCell"
    
    func prepare(_ data: MockModel) {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

struct MockModel: Hashable {
    let title: String
    
    init(title: String = "Mock") {
        self.title = title
    }
}
