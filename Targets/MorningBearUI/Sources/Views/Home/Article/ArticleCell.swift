//
//  ArticleCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

public class ArticleCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
            descriptionLabel.numberOfLines = 2
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        designCell()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(article: nil)
    }
    
    public func prepare(article: Article?) {
        self.imageView.image = article?.image
        self.titleLabel.text = article?.title
        self.descriptionLabel.text = article?.description
    }
}

private extension ArticleCell {
    func designCell() {
        self.layer.cornerRadius = 12
    }
}
