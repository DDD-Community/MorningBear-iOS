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
            profileImageView.backgroundColor = .clear
            profileImageView.contentMode = .scaleAspectFit
            profileImageView.clipsToBounds = true
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
    
    // MARK: - Counter contexts
    @IBOutlet weak var countHorizontalStack: UIStackView!
    
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
    
    // MARK: - Button context
    @IBOutlet weak var actionButton: UIButton! {
        didSet {
            actionButton.setTitleColor(.white, for: .normal)
            actionButton.titleLabel?.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
            actionButton.titleEdgeInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
    }
    private var buttonAction: (() -> Void)!
    
    // MARK: - View methods
    public override func prepareForReuse() {
        super.prepareForReuse()
        clearCell()
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        profileImageView.layer.mask = circleMaskLayer(frame: profileImageView.frame)
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
    }
}

public extension ProfileCell {
    func prepare(_ data: Profile) {
        if let buttonContext = data.buttonContext {
            self.prepare(
                image: data.image,
                nickname: data.nickname,
                buttonText: buttonContext.buttonText,
                buttonAction: buttonContext.buttonAction
            )
        } else if let countContext = data.countContext {
            self.prepare(
                image: data.image,
                nickname: data.nickname,
                postCount: countContext.postCount,
                supportCount: countContext.supportCount,
                badgeCount: countContext.badgeCount
            )
        }
    }
}

private extension ProfileCell {
    func prepare(image: UIImage, nickname: String, postCount: Int, supportCount: Int, badgeCount: Int) {
        actionButton.isHidden = true
        countHorizontalStack.isHidden = false
        
        backgroundColor = MorningBearUIAsset.Colors.gray900.color

        profileImageView.image = image
        nicknameLabel.text = nickname
        
        postCountLabel.text = String(postCount)
        supportCountLabel.text = String(supportCount)
        badgeCountLabel.text = String(badgeCount)
    }
    
    func prepare(image: UIImage, nickname: String, buttonText: String, buttonAction: @escaping () -> Void) {
        countHorizontalStack.isHidden = true
        actionButton.isHidden = false
        
        backgroundColor = .clear
        
        profileImageView.image = image
        nicknameLabel.text = nickname
        
        self.buttonAction = buttonAction
        actionButton.setTitle(buttonText, for: .normal)
        actionButton.addTarget(self, action: #selector(buttonActionWrapper), for: .touchUpInside)
    }
    
    @objc
    func buttonActionWrapper() {
        buttonAction()
    }
    
    func clearCell() {
        profileImageView.image = nil
        
        nicknameLabel.text = nil
        postCountLabel.text = nil
        supportCountLabel.text = nil
        badgeCountLabel.text = nil
        
        actionButton.setTitle(nil, for: .normal)
        buttonAction = nil
    }
    
    func circleMaskLayer(frame: CGRect) -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        let circlePath = UIBezierPath(ovalIn: frame)
        
        maskLayer.path = circlePath.cgPath
        maskLayer.fillColor = UIColor.white.cgColor

        return maskLayer
    }
}
