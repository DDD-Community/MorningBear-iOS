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
    private var placeHolderText: String? {
        didSet {
            self.text = placeHolderText
            self.textColor = MorningBearUIAsset.Colors.gray500.color
        }
    }
    
    private var isDirty: Bool = false
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        delegate = self
        
        designTextView()
    }
}

public extension MorningBearUITextView {
    func placeholder(text: String) {
        self.placeHolderText = text
    }
}

private extension MorningBearUITextView {
    func designTextView() {
        // Set border
        self.layer.cornerRadius = 12
        self.layer.borderColor = MorningBearUIAsset.Colors.gray500.color.cgColor
        self.layer.borderWidth = 1
        
        // Set background
        self.backgroundColor = .clear
        
        // Set content configs
        self.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 14)
        self.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
        // Scroll
        self.isScrollEnabled = false
    }
}

extension MorningBearUITextView: UITextViewDelegate {
    public func textViewDidBeginEditing(_ textView: UITextView) {
       if isDirty == false {
           textView.text = nil // 텍스트를 날려줌
           textView.textColor = UIColor.white
           
           isDirty = true
       }
   }
    
   // UITextView의 placeholder
    public func textViewDidEndEditing(_ textView: UITextView) {
       if textView.text.isEmpty {
           textView.text = placeHolderText
           textView.textColor = MorningBearUIAsset.Colors.gray500.color
           
           isDirty = false
       }
   }
   
}
