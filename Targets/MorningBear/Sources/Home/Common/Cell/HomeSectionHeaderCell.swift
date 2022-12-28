//
//  TitleHeaderViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit
import MorningBearKit

class HomeSectionHeaderCell: UICollectionViewCell {
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.distribution = .equalSpacing
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var moreButton: UIButton! {
        didSet {
            moreButton.setTitleColor(MorningBearAsset.Colors.captionText.color, for: .normal)
            moreButton.titleLabel?.font = MorningBearFontFamily.Pretendard.regular.font(size: 12)
        }
    }
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

        self.titleLabel.text = titleText
        self.moreButton.setTitle(descText, for: .normal)
    }
}
