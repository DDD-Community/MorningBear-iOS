//
//  MorningBearBarButtonItem.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/30.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit

public struct MorningBearBarButtonItem {
    public static let titleButton =  UIBarButtonItem(title: "모닝베어~")
    public static let searchButton = UIBarButtonItem(systemItem: .search)
    public static let notificationButton = UIBarButtonItem(systemItem: .rewind)
    public static let backButton = UIBarButtonItem(image: MorningBearUIAsset.Asset.backArrow.image.withTintColor(.black))
}
