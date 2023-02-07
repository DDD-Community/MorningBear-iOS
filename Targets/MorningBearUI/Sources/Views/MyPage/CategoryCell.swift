//
//  MyCategoryCell.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/31.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
@_exported import MorningBearData

public class CategoryCell: UICollectionViewCell, CustomCellType {
    public static var filename = "CategoryCell"
    public static let reuseIdentifier = "CategoryCell"
    public static let bundle = MorningBearUIResources.bundle

    @IBOutlet weak var iconImageView: UIImageView! {
        didSet {
            iconImageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.textColor = .white
            descriptionLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    public func prepare(_ data: MorningBearData.Category) {
        iconImageView.image = MorningBearUIAsset.Images.bonfire.image
        descriptionLabel.text = data.description
    }
}


