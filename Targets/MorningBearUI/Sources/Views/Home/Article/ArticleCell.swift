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
    
    @IBOutlet weak var titleLabel: UILabel! 
    @IBOutlet weak var descriptionLabel: UILabel!
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(article: nil)
    }
    
    public func prepare(article: Article?) {
        guard let article = article else {
            return
        }
        
        self.imageView.image = article.image
        self.titleLabel.text = article.title
        self.descriptionLabel.text = article.description
    }
}
