//
//  StateViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

class StateCell: UICollectionViewCell {
    @IBOutlet weak var stateWrapperView: UIView! {
        didSet {
            stateWrapperView.backgroundColor = .white
            stateWrapperView.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearFontFamily.Pretendard.bold.font(size: 24)
        }
    }
    @IBOutlet weak var subTitleLabel: UILabel! {
        didSet {
            subTitleLabel.font = MorningBearFontFamily.Pretendard.regular.font(size: 16)
            subTitleLabel.textColor = MorningBearAsset.Colors.secondaryText.color
        }
    }
    
    @IBOutlet weak var countTitleLabel: UILabel! {
        didSet {
            countTitleLabel.font = MorningBearFontFamily.Pretendard.regular.font(size: 12)
            countTitleLabel.textColor = MorningBearAsset.Colors.disabledText.color
        }
    }
    @IBOutlet weak var timeTitleLabel: UILabel! {
        didSet {
            timeTitleLabel.font = MorningBearFontFamily.Pretendard.regular.font(size: 12)
            timeTitleLabel.textColor = MorningBearAsset.Colors.disabledText.color
        }
    }
    @IBOutlet weak var badgeTitleLabel: UILabel! {
        didSet {
            badgeTitleLabel.font = MorningBearFontFamily.Pretendard.regular.font(size: 12)
            badgeTitleLabel.textColor = MorningBearAsset.Colors.disabledText.color
        }
    }
    
    
    @IBOutlet weak var countLabel: UILabel! {
        didSet {
            countLabel.font = MorningBearFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = MorningBearFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var badgeLabel: UILabel! {
        didSet {
            badgeLabel.font = MorningBearFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(state: nil)
    }
    
    func prepare(state: State?) {
        self.titleLabel.text = state?.nickname
    }
}
