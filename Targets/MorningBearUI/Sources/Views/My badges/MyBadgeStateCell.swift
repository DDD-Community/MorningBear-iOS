//
//  MyBadgeStateCell.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2023/01/01.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public class MyBadgeStateCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
        }
    }
    @IBOutlet weak var subtitleLabel: UILabel! {
        didSet {
            subtitleLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 14)
        }
    }
    @IBOutlet weak var divider: UIView! {
        didSet {
            divider.backgroundColor = MorningBearUIAsset.Colors.gray300.color
        }
    }
    
    public func prepare(_ state: MyBadgeState) {
        prepareCell(state)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        prepareCell(nil)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
}

extension MyBadgeStateCell {
    private func titleLabelParser(nickname: String, badgeCount: Int) -> String {
        return "\(nickname)님은 \n\(badgeCount)개의 배지를 받으셨어요!"
    }
    
    private func subtitleLabelParser(nickname: String, badgeCount: Int) -> String {
        if badgeCount >= 15 {
            return "배지를 모두 모았어요.\n 축하합니다 🎉"
        } else {
            return "아직 받지 못한 배지가 \(15-badgeCount)개 있어요.\n모닝베어와 함께 열심히 인증해요!"
        }
    }
    
    private func prepareCell(_ state: MyBadgeState?) {
        guard let state else {
            titleLabel.text = nil
            subtitleLabel.text = nil
            return 
        }
        
        titleLabel.text = titleLabelParser(nickname: state.nickname,
                                           badgeCount: state.badgeCount)
        subtitleLabel.text = subtitleLabelParser(nickname: state.nickname,
                                                 badgeCount: state.badgeCount)
    }
}
