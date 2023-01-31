//
//  ProfileCell.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/31.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public class ProfileCell: UICollectionViewCell, CustomCellType {
    public static let filename = "ProfileCell"
    public static let reuseIdentifier = "ProfileCell"
    
    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.contentMode = .scaleAspectFit
        }
    }
    
    @IBOutlet weak var nicknameLabel: UILabel! {
        didSet {
            nicknameLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            nicknameLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var postTitileLabel: UILabel! {
        didSet {
            postTitileLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            postTitileLabel.textColor = .white
        }
    }
    @IBOutlet weak var postCountLabel: UILabel! {
        didSet {
            postCountLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            postCountLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var supportTitleLabel: UILabel! {
        didSet {
            supportTitleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            supportTitleLabel.textColor = .white
        }
    }
    @IBOutlet weak var supportCountLabel: UILabel! {
        didSet {
            supportCountLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            supportCountLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var badgeTitleLabel: UILabel! {
        didSet {
            badgeTitleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            badgeTitleLabel.textColor = .white
        }
    }
    @IBOutlet weak var badgeCountLabel: UILabel! {
        didSet {
            badgeCountLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            badgeCountLabel.textColor = .white
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        prepareCell()
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        prepareCell() 
    }
}

public extension ProfileCell {
    func prepare(image: UIImage, nickname: String, postCount: Int, supportCount: Int, badgeCount: Int) {
        profileImageView.image = image
        
        nicknameLabel.text = nickname
        postCountLabel.text = String(postCount)
        supportCountLabel.text = String(supportCount)
        badgeCountLabel.text = String(badgeCount)
    }
}

private extension ProfileCell {
    func prepareCell() {
        profileImageView.image = nil
        
        nicknameLabel.text = nil
        postCountLabel.text = nil
        supportCountLabel.text = nil
        badgeCountLabel.text = nil
    }
}
