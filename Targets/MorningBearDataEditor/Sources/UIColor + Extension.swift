//
//  UIColor + Extension.swift
//  MorningBearDataProvider
//
//  Created by 이영빈 on 2023/01/19.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// 임시로 사용하는 샘플 이미지 제너레이터
extension UIColor {
    static var random: UIColor {
        UIColor(
            red: CGFloat(drand48()),
            green: CGFloat(drand48()),
            blue: CGFloat(drand48()),
            alpha: 1.0
        )
    }

    func image(_ size: CGSize = CGSize(width: 1, height: 1)) -> UIImage {
        return UIGraphicsImageRenderer(size: size).image { rendererContext in
            self.setFill()
            rendererContext.fill(CGRect(origin: .zero, size: size))
        }
    }
}
