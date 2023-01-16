//
//  CALayer + Extension.swift
//  MorningBearUI
//
//  Created by 이영빈 on 2023/01/15.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

extension CALayer {
    public func dropShadow(_ type: ShadowType) {
        let option = type.option
        option.drop(self)
    }
    
    public enum ShadowType {
        case standard
            
        var option: ShadowOption {
            switch self {
            case .standard:
                return ShadowOption(radius: 15, color: .black, opacity: 0.15)
            }
        }
    }
    
    struct ShadowOption {
        let radius: CGFloat
        let color: UIColor
        let opacity: Float
        
        func drop(_ layer: CALayer) {
            layer.shadowRadius = radius
            layer.shadowColor = color.cgColor
            layer.shadowOpacity = opacity
        }
    }
}
