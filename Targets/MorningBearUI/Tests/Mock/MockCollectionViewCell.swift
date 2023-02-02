//
//  MockCollectionViewCell.swift
//  MorningBearUITests
//
//  Created by Young Bin on 2023/02/02.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

@testable import MorningBearUI

class MockCollectionViewCell: UICollectionViewCell, CustomCellType {
    static var filename: String = "MockCollectionViewCell"
    static var reuseIdentifier: String = "MockCollectionViewCell"
    
    func prepare(_ data: MockModel) {}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

struct MockModel {}
