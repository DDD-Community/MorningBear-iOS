//
//  DividerCell.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/02/06.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public class DividerCell: UICollectionViewCell, CustomCellType {
    @IBOutlet weak var dividerView: UIView! {
        didSet {
            backgroundColor = MorningBearUIAsset.Colors.gray900.color
        }
    }
    
    public static let filename: String = "DividerCell"
    public static let reuseIdentifier: String = "DividerCell"
    public static let bundle: Bundle = MorningBearUIResources.bundle
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backgroundColor = MorningBearUIAsset.Colors.gray900.color
    }
    
    public func prepare(_ data: Void) {}
}
