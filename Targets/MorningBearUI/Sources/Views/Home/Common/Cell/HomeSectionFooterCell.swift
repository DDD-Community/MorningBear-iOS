//
//  HomeSectionFooterCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

public class HomeSectionFooterCell: UICollectionViewCell {
    @IBOutlet weak var button: UIButton! {
        didSet {
            button.titleLabel?.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            button.setTitleColor(.black, for: .normal)
            
            button.backgroundColor = .white
            button.sizeToFit()
            
            button.layer.cornerRadius = 10
            button.layer.shadowColor = UIColor.gray.cgColor
            button.layer.shadowOpacity = 0.3
            button.layer.shadowRadius = 8
            button.layer.shadowOffset = .zero
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.masksToBounds = false
        // Initialization code
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(buttonText: nil)
    }
    
    public func prepare(buttonText: String?) {
        self.button.setTitle(buttonText, for: .normal)
    }
}

extension HomeSectionFooterCell {
    private func designCell() {
        
    }
    
    private func configureFont() {
        button.titleLabel?.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        button.setTitleColor(.black, for: .normal)
    }
}
