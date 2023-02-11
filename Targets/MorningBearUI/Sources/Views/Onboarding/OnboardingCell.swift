//
//  OnboardingCell.swift
//  MorningBear
//
//  Created by 이건우 on 2022/12/14.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

import MorningBearData

public class OnboardingCell: UICollectionViewCell {
    public static let reuseIdentifier = String(describing: OnboardingCell.self)
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFill
        }
    }
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.Typography.displaySmall.font
            titleLabel.textColor = .white
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = MorningBearUIFontFamily.Pretendard.Typography.bodyLarge.font
            descriptionLabel.textColor = .white
            descriptionLabel.numberOfLines = 2
            descriptionLabel.textAlignment = .center
        }
    }
    
    public func configure(data: OnboardingData) {
        imageView.image = data.image
        titleLabel.text = data.title
        descriptionLabel.text = data.description
    }
}
