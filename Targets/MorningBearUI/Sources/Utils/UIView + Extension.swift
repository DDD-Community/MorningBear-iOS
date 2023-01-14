//
//  UIView + Extension.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/11.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// Xib와 View의 이름이 같아야 함
extension UIView {
    func loadXib() {
        let identifier = String(describing: type(of: self))

        let nibs = MorningBearUIResources.bundle.loadNibNamed(identifier, owner: self, options: nil)

        guard let customView = nibs?.first as? UIView else { return }
        customView.frame = self.bounds

        self.addSubview(customView)
    }
}
