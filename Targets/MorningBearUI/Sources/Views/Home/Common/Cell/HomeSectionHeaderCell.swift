//
//  TitleHeaderViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

public class HomeSectionHeaderCell: UICollectionViewCell {
    @IBOutlet weak var stackView: UIStackView! {
        didSet {
            stackView.distribution = .equalSpacing
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var moreButton: UIButton! {
        didSet {
            moreButton.setTitleColor(MorningBearUIAsset.Colors.captionText.color, for: .normal)
            moreButton.titleLabel?.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
        }
    }
    private var needsButton = false {
        didSet {
            // 버튼이 필요하면 숨기지 말 것
            moreButton.isHidden = !needsButton
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.prepare(descText: nil, titleText: nil, needsButton: self.needsButton)
    }
    
    public func prepare(descText: String?, titleText: String?, needsButton: Bool = true) {
        self.needsButton = needsButton

        self.titleLabel.text = titleText
        self.moreButton.setTitle(descText, for: .normal)
    }
}
