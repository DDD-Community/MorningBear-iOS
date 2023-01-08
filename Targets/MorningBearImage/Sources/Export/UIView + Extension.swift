//
//  MorningBearImageOverlay.swift
//  MorningBearKit
//
//  Created by Young Bin on 2023/01/08.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// 보이는 `UIVIew`를 그대로 `UIImage`로 바꿔줌
public extension UIView {
    var toUIImage: UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0.0)
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return image
    }
}

