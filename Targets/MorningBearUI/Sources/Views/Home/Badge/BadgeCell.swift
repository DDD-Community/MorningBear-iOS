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
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        
        self.prepare(badge: nil)
    }
    
    public func prepare(badge: Badge?) {
        guard let data = badge else {
            return
        }
        
        self.imageView.image = data.image
    }
}
