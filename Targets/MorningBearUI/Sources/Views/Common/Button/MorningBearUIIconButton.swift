//
//  CircularIconButon.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/04.
//  Copyright © 2023 com.dache. All rights reserved.
//
//

import UIKit

// MARK: For internal use
public class MorningBearUIIconButton: UIButton {
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        designButton()
    }
    
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        
        // Set image configs
        self.imageView?.contentMode = .scaleAspectFit
    }
}

public extension MorningBearUIIconButton {
    func shape(icon: Icon) {
        self.setImage(icon.image, for: .normal)
    }
    
    enum Icon {
        case pencil
        case questionMark
        
        var image: UIImage {
            switch self {
            case .pencil:
                return MorningBearUIAsset.Asset.pencil.image
            case .questionMark:
                return MorningBearUIAsset.Asset.questionmarkCircle.image
            }
        }
    }
}

// MARK: Internal tools
private extension MorningBearUIIconButton {
    func designButton() {
        // Set colors
        self.backgroundColor = .clear
        
        // Set text attributes
        self.setTitle("", for: .normal)
    }
}

