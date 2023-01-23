//
//  Font + Extension.swift
//  MorningBear
//
//  Created by 이건우 on 2023/01/20.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public extension MorningBearUIFontFamily.Pretendard {
    enum Typography {
        /// Bold / 40
        case displayLarge
        /// Bold / 32
        case displayMedium
        /// Bold / 28
        case displaySmall
        /// Bold / 14
        case displayXS
        
        /// Bold / 24
        case headLarge
        /// Bold / 20
        case headMedium
        /// Bold / 16
        case headSmall
        /// Medium / 16
        case headXS
        
        /// Regular / 16
        case bodyLarge
        /// Regular / 14
        case bodyMedium
        /// Regular / 12
        case bodySmall
    }
}

public extension MorningBearUIFontFamily.Pretendard.Typography {
    var font: MorningBearUIFontConvertible.Font {
        switch self {
        case .displayLarge:
            return MorningBearUIFontFamily.Pretendard.bold.font(size: 40)
        case .displayMedium:
            return MorningBearUIFontFamily.Pretendard.bold.font(size: 32)
        case .displaySmall:
            return MorningBearUIFontFamily.Pretendard.bold.font(size: 28)
        case .displayXS:
            return MorningBearUIFontFamily.Pretendard.bold.font(size: 14)
        case .headLarge:
            return MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
        case .headMedium:
            return MorningBearUIFontFamily.Pretendard.bold.font(size: 20)
        case .headSmall:
            return MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        case .headXS:
            return MorningBearUIFontFamily.Pretendard.medium.font(size: 16)
        case .bodyLarge:
            return MorningBearUIFontFamily.Pretendard.regular.font(size: 16)
        case .bodyMedium:
            return MorningBearUIFontFamily.Pretendard.regular.font(size: 14)
        case .bodySmall:
            return MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
        }
    }
}
