//
//  MorningBearTextView.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/04.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// 앱 전반에 걸쳐 사용되는 **여러줄** 텍스트 뷰
///
/// `UITextView`를 상속해서 사용. 디자인 요소 외에`UITextView`와 모두 동일하므로
/// 같은 방식으로 설정해서 사용하면 된다.
public class MorningBearUITextView: UITextView {
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        designTextView()
    }
}

private extension MorningBearUITextView {
    func designTextView() {
        // Set border
        self.layer.cornerRadius = 12
        self.layer.borderColor = MorningBearUIAsset.Colors.gray200.color.cgColor
        self.layer.borderWidth = 1
        
        // Set background
        self.backgroundColor = .clear
        
        // Set content configs
        self.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 14)
        self.contentInset = UIEdgeInsets(top: 3, left: 3, bottom: 3, right: 3)
        
        // Scroll
        self.isScrollEnabled = false
    }
}
