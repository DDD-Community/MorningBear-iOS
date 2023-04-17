//
//  StateViewCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import RxCocoa
import RxSwift

import MorningBearData

public class StateCell: UICollectionViewCell {
    private let bag = DisposeBag()
    
    @IBOutlet weak var oneLinerButton: UIButton! {
        didSet {
            oneLinerButton.backgroundColor = MorningBearUIAsset.Colors.gray800.color
            oneLinerButton.layer.cornerRadius = 8
            
            oneLinerButton.setTitleColor(.white, for: .normal)
            oneLinerButton.titleLabel?.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
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
    
    public typealias Action = () -> Void
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(state: nil, myInfo: nil, tapAction: nil)
    }
    
    public func prepare(state: State?, myInfo: MyInfo?, tapAction: Action?) {
        let titleLabelText: String?
        if let state {
            titleLabelText = "안녕하세요, \(state.nickname)"
        } else {
            titleLabelText = "안녕하세요!"
        }
        
        titleLabel.text = titleLabelText
        
        oneLinerButton.setTitle(state?.oneLiner, for: .normal)
        bindButton(with: tapAction)
        
        countLabel.text = String(parseToHourAndMinute(from: myInfo?.estimatedTime))
        timeLabel.text = String("\(myInfo?.totalCount ?? 0)번")
        badgeLabel.text = String("\(myInfo?.badgeCount ?? 0)개")
    }
}

private extension StateCell {
    func bindButton(with action: Action?) {
        oneLinerButton.rx.tap.bind {
            action?()
        }
        .disposed(by: bag)
    }
    
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
