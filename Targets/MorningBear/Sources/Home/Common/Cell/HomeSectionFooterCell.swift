//
//  FooterViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

class HomeSectionFooterCell: UICollectionViewCell {
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(buttonText: nil)
    }
    
    func prepare(buttonText: String?) {
        self.button.setTitle(buttonText, for: .normal)
    }
}
