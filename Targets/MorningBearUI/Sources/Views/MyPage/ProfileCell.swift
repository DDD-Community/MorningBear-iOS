//
//  ProfileCell.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/31.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
@_exported import MorningBearData

public class ProfileCell: UICollectionViewCell, CustomCellType {
    public static let filename = "ProfileCell"
    public static let reuseIdentifier = "ProfileCell"
    public static let bundle = MorningBearUIResources.bundle

    @IBOutlet weak var profileImageView: UIImageView! {
        didSet {
            profileImageView.contentMode = .scaleAspectFit
            clipsToBounds = true
        }
    }
    
    @IBOutlet weak var nicknameLabel: UILabel! {
        didSet {
            nicknameLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            nicknameLabel.textColor = .white
        }
    }
    
    @IBOutlet weak var postTitileLabel: UILabel! {
        didSet {
            postTitileLabel.text = "게시글"
            postTitileLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            postTitileLabel.textColor = .white
        }
    }
    @IBOutlet weak var postCountLabel: UILabel! {
        didSet {
            postCountLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            postCountLabel.textColor = MorningBearUIAsset.Colors.gray700.color
        }
    }
    
    @IBOutlet weak var supportTitleLabel: UILabel! {
        didSet {
            supportTitleLabel.text = "받은응원"
            supportTitleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            supportTitleLabel.textColor = .white
        }
    }
    @IBOutlet weak var supportCountLabel: UILabel! {
        didSet {
            supportCountLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            supportCountLabel.textColor = MorningBearUIAsset.Colors.gray700.color
        }
    }
    
    @IBOutlet weak var badgeTitleLabel: UILabel! {
        didSet {
            badgeTitleLabel.text = "보유뱃지"
            badgeTitleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            badgeTitleLabel.textColor = .white
        }
    }
    @IBOutlet weak var badgeCountLabel: UILabel! {
        didSet {
            badgeCountLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            badgeCountLabel.textColor = MorningBearUIAsset.Colors.gray700.color
        }
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        prepareCell()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        profileImageView.layer.mask = circleMaskLayer(frame: profileImageView.frame)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = MorningBearUIAsset.Colors.gray900.color
        layer.cornerRadius = 8
        
        prepareCell() 
    }
}

public extension ProfileCell {
    func prepare(_ data: Profile) {
        self.prepare(image: data.image,
                     nickname: data.nickname,
                     postCount: data.postCount,
                     supportCount: data.supportCount,
                     badgeCount: data.badgeCount)
    }
    
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
    
    func circleMaskLayer(frame: CGRect) -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        let circlePath = UIBezierPath(ovalIn: frame)
        
        maskLayer.path = circlePath.cgPath
        maskLayer.fillColor = UIColor.white.cgColor

        return maskLayer
    }
}
