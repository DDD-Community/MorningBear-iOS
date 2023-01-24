//
//  ActivityCell.swift
//  MorningBearUI
//
//  Created by 이건우 on 2023/01/24.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// 관심있는 미라클모닝 활동을 설정, 수정할 떄 사용되는 셀입니다
public class ActivityCell: UICollectionViewCell {
    public static let reuseIdentifier = String(describing: ActivityCell.self)
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.contentMode = .scaleAspectFit
        }
    }
    @IBOutlet weak var activityName: UILabel! {
        didSet {
            activityName.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            activityName.textColor = MorningBearUIAsset.Colors.disabledText.color
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        designCell()
    }
    
    public func configure(data: Activity) {
        imageView.image = data.image
        activityName.text = data.name
    }
}

extension ActivityCell {
    func designCell() {
        self.backgroundColor = MorningBearUIAsset.Colors.gray900.color
        self.layer.cornerRadius = 12
    }
}
