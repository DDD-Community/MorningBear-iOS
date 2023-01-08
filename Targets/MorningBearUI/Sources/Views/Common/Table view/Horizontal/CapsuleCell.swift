//
//  HorizontalCapsuleCellTableViewCell.swift
//  MorningBear
//
//  Created by Young Bin on 2023/01/08.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public class CapsuleCell: UICollectionViewCell {
    @IBOutlet weak var contentLabel: UILabel! {
        didSet {
            contentLabel.textColor = .white
            contentLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 14)
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        prepareCell(title: nil)
        layer.cornerRadius = 15
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 1
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        prepareCell(title: nil)
    }
}

public extension CapsuleCell {
    func prepare(title: String) {
        prepareCell(title: title)
    }
}

private extension CapsuleCell {
    func prepareCell(title: String?) {
        contentLabel.text = title
    }
}
