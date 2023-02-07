//
//  MorningBearBarButtonItem.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/30.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

public struct MorningBearBarButtonItem {
    public static func textButton(_ text: String) -> UIBarButtonItem {
        let button = UIBarButtonItem(title: text)
        let titleAttributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.white,
            .font: MorningBearUIFontFamily.Pretendard.bold.font(size: 20)
        ]
        
        button.setTitleTextAttributes(titleAttributes, for: .normal)
        return button
    }
    
    public static let titleButton =  UIBarButtonItem(image: MorningBearUIAsset.Images.tempLogo.image.withRenderingMode(.alwaysOriginal))
    public static let searchButton = UIBarButtonItem(systemItem: .search)
    public static let notificationButton = UIBarButtonItem(image: MorningBearUIAsset.Images.bell.image.withRenderingMode(.alwaysOriginal))
    
    public static let backButton = UIBarButtonItem(image: MorningBearUIAsset.Images.backArrow.image.withRenderingMode(.alwaysOriginal))
    public static let settingButton = UIBarButtonItem(
        image: MorningBearUIAsset.Images.setting.image.withRenderingMode(.alwaysOriginal)
    )
}
