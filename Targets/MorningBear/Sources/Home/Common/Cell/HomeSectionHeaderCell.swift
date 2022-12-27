//
//  TitleHeaderViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

class HomeSectionHeaderCell: UICollectionViewCell {
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    private var needsButton = false {
        didSet {
            // 버튼이 필요하면 숨기지 말 것
            moreButton.isHidden = !needsButton
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(descText: nil, titleText: nil, needsButton: self.needsButton)
    }
    
    func prepare(descText: String?, titleText: String?, needsButton: Bool = true) {
        self.needsButton = needsButton
        self.moreButton.setTitle(descText, for: .normal)
        self.titleLabel.text = titleText
    }
}
