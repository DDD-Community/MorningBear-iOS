//
//  ConceptCell.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/26.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import Kingfisher
@_exported import MorningBearData

public final class RecentMorningCell: UICollectionViewCell, CustomCellType {
    public static let filename = "RecentMorningCell"
    public static let reuseIdentifier = "RecentMorningCell"
    public static let bundle = MorningBearUIResources.bundle
    
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
    
    public func prepare(_ data: MyMorning) {
        prepareCell(data)
    }
}

extension RecentMorningCell {
    private func prepareCell(_ data: MyMorning?) {
        self.imageView.kf.setImage(with: data?.imageURL)
    }
}
