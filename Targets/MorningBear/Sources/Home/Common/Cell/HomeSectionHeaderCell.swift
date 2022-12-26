//
//  TitleHeaderViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

class HomeSectionHeaderCell: UICollectionViewCell {
    @IBOutlet weak var descButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(descText: nil, titleText: nil)
    }
    
    func prepare(descText: String?, titleText: String?) {
        self.descButton.setTitle(descText, for: .normal)
        self.titleLabel.text = titleText
    }
}
