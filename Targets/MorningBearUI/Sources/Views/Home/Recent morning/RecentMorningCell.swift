//
//  ConceptCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import MorningBearData

public final class RecentMorningCell: UICollectionViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 10
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        self.prepareCell(nil)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        self.prepareCell(nil)
    }
    
    public func prepare(_ data: RecentMorning) {
        prepareCell(data)
    }
}

extension RecentMorningCell {
    private func prepareCell(_ data: RecentMorning?) {
        self.imageView.image = data?.image
        self.titleLabel.text = data?.title
    }
}
