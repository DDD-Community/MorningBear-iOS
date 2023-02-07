//
//  HorizontalCapsuleCellTableViewCell.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/08.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public class CapsuleCell: UICollectionViewCell, HorizontalScrollCellType, CustomCellType {
    public static let filename = "CapsuleCell"
    public static let reuseIdentifier = "CapsuleCell"
    public static let bundle = MorningBearUIResources.bundle
    
    public override var isSelected: Bool{
        willSet{
            super.isSelected = newValue
            if newValue == true {
                self.layer.borderColor = MorningBearUIAsset.Colors.primaryDefault.color.cgColor
                self.backgroundColor = MorningBearUIAsset.Colors.primaryDefault.color
                self.contentLabel.textColor = .white
            } else {
                self.layer.borderColor = MorningBearUIAsset.Colors.gray500.color.cgColor
                self.backgroundColor = .clear
                self.contentLabel.textColor = MorningBearUIAsset.Colors.gray500.color
            }
        }
    }
    
    public var contentText: String? {
        return contentLabel.text
    }
    
    @IBOutlet weak var contentLabel: UILabel! {
        didSet {
            contentLabel.textColor = MorningBearUIAsset.Colors.gray500.color
            contentLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 14)
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCell(title: nil)
        layer.cornerRadius = 15
        layer.borderColor = MorningBearUIAsset.Colors.gray500.color.cgColor
        layer.borderWidth = 1
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        prepareCell(title: nil)
    }
}

public extension CapsuleCell {
    func prepare(_ data: String) {
        prepareCell(title: data)
    }
    
    func prepare(title: String) {
        prepareCell(title: title)
    }
}

private extension CapsuleCell {
    func prepareCell(title: String?) {
        contentLabel.text = title
    }
}
