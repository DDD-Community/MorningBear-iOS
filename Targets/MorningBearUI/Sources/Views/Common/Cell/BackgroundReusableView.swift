//
//  BackgroundReusableView.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/02/06.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public class BackgroundReusableView: UICollectionReusableView {
    @IBOutlet weak var backgroundView: UIView! {
        didSet {
            backgroundColor = MorningBearUIAsset.Colors.gray900.color
        }
    }
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
    }
}
