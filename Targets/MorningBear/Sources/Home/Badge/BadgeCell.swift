//
//  BadgeCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/27.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

class BadgeCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(badge: nil)
    }
    
    func prepare(badge: Badge?) {
        self.imageView.image = badge?.image
    }
}
