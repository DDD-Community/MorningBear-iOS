//
//  LargeButton.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/03.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public class LargeButton: UIButton {
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        designButton()
    }
}

private extension LargeButton {
    func designButton() {
        // Set colors
        self.backgroundColor = MorningBearUIAsset.Colors.primaryDefault.color
        self.setTitleColor(.white, for: .normal)
        
        // Set font
        self.titleLabel?.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        
        // Set shape
        self.layer.cornerRadius = 12
    }
}
