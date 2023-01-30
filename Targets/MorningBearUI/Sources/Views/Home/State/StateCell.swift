//
//  StateViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import MorningBearData

public class StateCell: UICollectionViewCell {
    @IBOutlet weak var oneLinerWrapperView: UIView! {
        didSet {
            oneLinerWrapperView.backgroundColor = MorningBearUIAsset.Colors.gray800.color
            oneLinerWrapperView.layer.cornerRadius = 8
        }
    }
    @IBOutlet weak var oneLinerLabel: UILabel! {
        didSet {
            oneLinerLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var stateWrapperView: UIView! {
        didSet {
            stateWrapperView.layer.cornerRadius = 12
            stateWrapperView.backgroundColor = MorningBearUIAsset.Colors.gray900.color
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
            titleLabel.textColor = MorningBearUIAsset.Colors.primaryText.color
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
            countLabel.textColor = MorningBearUIAsset.Colors.primaryText.color
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            timeLabel.textColor = MorningBearUIAsset.Colors.primaryText.color
        }
    }
    @IBOutlet weak var badgeLabel: UILabel! {
        didSet {
            badgeLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            badgeLabel.textColor = MorningBearUIAsset.Colors.primaryText.color
        }
    }
    
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(state: nil, myInfo: nil)
    }
    
    public func prepare(state: State?, myInfo: MyInfo?) {
        let titleLabelText: String?
        if let state {
            titleLabelText = "안녕하세요, \(state.nickname)님"
        } else {
            titleLabelText = "안녕하세요!"
        }
        
        titleLabel.text = titleLabelText
        oneLinerLabel.text = state?.oneLiner
        
        countLabel.text = String(parseToHourAndMinute(from: myInfo?.estimatedTime))
        timeLabel.text = String("\(myInfo?.totalCount ?? 0)번")
        badgeLabel.text = String("\(myInfo?.badgeCount ?? 0)개")
    }
}

private extension StateCell {
    func parseToHourAndMinute(from totalMinute: Int?) -> String {
        guard var totalMinute else {
            return "0분"
        }
        
        let hour: Int = totalMinute / 60
        let minute = totalMinute % 60
        
        let text: String
        if hour < 1 {
            text = "\(minute)분"
        } else {
            text = "\(hour)시간 \(minute)분"
        }
        
        return text
    }
}
