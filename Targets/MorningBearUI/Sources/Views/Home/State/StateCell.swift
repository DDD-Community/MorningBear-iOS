//
//  StateViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

public class StateCell: UICollectionViewCell {
    @IBOutlet weak var stateWrapperView: UIView! {
        didSet {
            stateWrapperView.backgroundColor = .white
            stateWrapperView.layer.cornerRadius = 12
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
        }
    }
    @IBOutlet weak var subTitleLabel: UILabel! {
        didSet {
            subTitleLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 16)
            subTitleLabel.textColor = MorningBearUIAsset.Colors.secondaryText.color
        }
    }
    
    @IBOutlet weak var countTitleLabel: UILabel! {
        didSet {
            countTitleLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
            countTitleLabel.textColor = MorningBearUIAsset.Colors.disabledText.color
        }
    }
    @IBOutlet weak var timeTitleLabel: UILabel! {
        didSet {
            timeTitleLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
            timeTitleLabel.textColor = MorningBearUIAsset.Colors.disabledText.color
        }
    }
    @IBOutlet weak var badgeTitleLabel: UILabel! {
        didSet {
            badgeTitleLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
            badgeTitleLabel.textColor = MorningBearUIAsset.Colors.disabledText.color
        }
    }
    
    
    @IBOutlet weak var countLabel: UILabel! {
        didSet {
            countLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var badgeLabel: UILabel! {
        didSet {
            badgeLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(state: nil)
    }
    
    public func prepare(state: State?) {
        self.titleLabel.text = state?.nickname
    }
}
