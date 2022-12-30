//
//  ConceptCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

public final class RecentMorningCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 10
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(nil)
    }
    
    public func prepare(_ data: RecentMorning?) {
        guard let data = data else {
            return
        }
        
        self.imageView.image = data.image
        self.titleLabel.text = data.title
    }
}