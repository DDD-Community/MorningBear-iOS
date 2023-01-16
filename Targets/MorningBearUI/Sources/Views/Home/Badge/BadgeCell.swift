//
//  BadgeCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

public class BadgeCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
            imageView.clipsToBounds = true
            imageView.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
        }
    }
    @IBOutlet weak var badgeNameLabel: UILabel! {
        didSet {
            badgeNameLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            badgeNameLabel.textColor = MorningBearUIAsset.Colors.disabledText.color
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

        imageView.layer.mask = circleMaskLayer(frame: imageView.frame)
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
