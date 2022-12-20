//
//  OnboardingCell.swift
//  MorningBear
//
//  Created by 이건우 on 2022/12/14.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

class OnboardingCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    func configure(data: OnboardingData) {
        imageView.image = UIImage(named: data.image)
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
}
