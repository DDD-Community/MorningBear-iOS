//
//  CircularIconButon.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/04.
//  Copyright © 2023 com.dache. All rights reserved.
//
//

import UIKit

///.앱 전반에서 사용되는 아이콘 버튼
///
/// `UIButton`을 상속해서 사용. `shape`메소드를 이용해 아이콘을 고를 수 있다.
public class MorningBearUIIconButton: UIButton {
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        designButton()
    }
    
    /// 이미지가 후설정되는 경우를 대비해 이미지가 설정되면 같이 설정되어야 하는 옵션이 실행될 수 있도록 같이 오버라이딩 함
    public override func setImage(_ image: UIImage?, for state: UIControl.State) {
        super.setImage(image, for: state)
        
        // Set image configs
        self.imageView?.contentMode = .scaleAspectFit
    }
}

public extension MorningBearUIIconButton {
    /// 아이콘을 선택하면 해당 모양의 버튼을 보여준다
    ///
    /// 아이콘은 추후 직접 추가해 주어야 하는게 흠이라면 흠이다.
    func shape(icon: Icon) {
        self.setImage(icon.image, for: .normal)
    }
    
    /// 사용할 수 있는 아이콘 목록
    ///
    /// 여기에 아이콘이 추가될 때마다 같이 기입
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

