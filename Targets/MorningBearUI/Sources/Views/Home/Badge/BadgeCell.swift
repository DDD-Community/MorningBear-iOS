//
//  BadgeCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import MorningBearData

public class BadgeCell: UICollectionViewCell, CustomCellType {
    public static let filename = "BadgeCell"
    public static let reuseIdentifier = "BadgeCell"
    public static let bundle = MorningBearUIResources.bundle
    
    @IBOutlet weak var imageWrapperView: UIView! {
        didSet {
            imageWrapperView.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
            imageView.clipsToBounds = true
        }
    }
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
            imageView.backgroundColor = .clear
            
            imageView.clipsToBounds = false
            imageView.layer.masksToBounds = false
        }
    }
    @IBOutlet weak var badgeNameLabel: UILabel! {
        didSet {
            badgeNameLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            badgeNameLabel.textColor = .white
        }
    }
    @IBOutlet weak var badgeGainDateLabel: UILabel! {
        didSet {
            badgeGainDateLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
            badgeGainDateLabel.textColor = MorningBearUIAsset.Colors.captionText.color
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(badge: nil)
    }
    
    public override func draw(_ rect: CGRect) {
        super.draw(rect)

        imageWrapperView.layer.mask = circleMaskLayer(frame: imageWrapperView.frame)
    }
    
    public func prepare(_ data: Badge) {
        self.prepare(badge: data)
    }
    
    public func prepare(badge: Badge?) {
        guard let data = badge else {
            return
        }
        
        self.imageView.image = data.image
        self.badgeNameLabel.text = data.title
        self.badgeGainDateLabel.text = data.desc
    }
}

private extension BadgeCell {
    func designCell() {
        self.backgroundColor = MorningBearUIAsset.Colors.gray900.color
        self.layer.cornerRadius = 12
    }
    
    func circleMaskLayer(frame: CGRect) -> CAShapeLayer {
        let maskLayer = CAShapeLayer()
        let circlePath = UIBezierPath(ovalIn: frame)
        
        maskLayer.path = circlePath.cgPath
        maskLayer.fillColor = UIColor.white.cgColor

        return maskLayer
    }
}
