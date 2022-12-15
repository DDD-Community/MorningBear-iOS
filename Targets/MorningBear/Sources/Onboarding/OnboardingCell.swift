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
    
    func configure(
        indexPath: IndexPath,
        onboardingData: [OnboardingData]
    ) {
        imageView.image = UIImage(named: onboardingData[indexPath.row].image)
        titleLabel.text = onboardingData[indexPath.row].title
        descriptionLabel.text = onboardingData[indexPath.row].description
    }
}