//
//  CAGradientLayer + Extension.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/28.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public extension CAGradientLayer {
    static var random: CAGradientLayer {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = GradientColorSet.random
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        return gradientLayer
    }
}

struct GradientColorSet {
    typealias Colors = MorningBearUIAsset.Colors
    
    static private let colors: [[CGColor]] = [
        [Colors.grRedStart, Colors.grRedEnd],
        [Colors.grBlueAStart, Colors.grBlueAEnd],
        [Colors.grPurpleAStart, Colors.grPurpleAEnd],
        [Colors.grPurpleBStart, Colors.grPurpleBEnd],
        [Colors.grRedPinkStart, Colors.grRedPinkEnd],
        [Colors.grRedPurpleStart, Colors.grRedPurpleEnd],
        [Colors.grGrayAStart, Colors.grGrayAEnd],
        [Colors.grGrayBStart, Colors.grGrayBEnd]
    ].map {
        $0.map{ $0.color.cgColor }
    }
    
    static var random: [CGColor] {
        guard !colors.isEmpty else {
            fatalError("왜 컬러세트가 비어있을까요?")
        }
        
        return colors.randomElement()!
    }
}
