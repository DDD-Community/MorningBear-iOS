//
//  ConceptCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

final class RecentMorningCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 10
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(image: nil, titleText: nil)
    }
    
    func prepare(image: UIImage?, titleText: String?) {
        self.imageView.image = image
        self.titleLabel.text = titleText
    }
}
