//
//  ArticleCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

@_exported import MorningBearData

public class ArticleCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            titleLabel.textColor = .black
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            descriptionLabel.numberOfLines = 2
            descriptionLabel.textColor = .black
        }
    }
    var gradientLayer: CAGradientLayer = .random
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer = CAGradientLayer.random
        gradientLayer.frame = bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(article: nil)
    }
    
    public func prepare(article: Article?) {
        self.titleLabel.text = article?.title
        self.descriptionLabel.text = article?.description
    }
}

private extension ArticleCell {
    func designCell() {
        self.layer.cornerRadius = 12
    }
}
