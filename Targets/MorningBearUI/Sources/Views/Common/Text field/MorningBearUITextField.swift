//
//  MorningBearTextField.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/04.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

/// 앱 전반에 걸쳐 사용되는 한 줄짜리 텍스트 필드
///
/// `UITextField`를 상속해서 사용. 디자인 요소 외에`UITextField`와 모두 동일하므로
/// 같은 방식으로 설정해서 사용하면 된다.
public class MorningBearUITextField: UITextField {
    public typealias Action = () -> Void

    var submitAction: Action?

    public override func awakeFromNib() {
        super.awakeFromNib()
        
        designTextField()
    }
}

// MARK: - Set delegates
extension MorningBearUITextField: UITextFieldDelegate {
    public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let submitAction {
            submitAction()
        }
        
        textField.resignFirstResponder()
        return true
    }
}

// MARK: - Methods for public use
public extension MorningBearUITextField {
    func onSubmit(action: @escaping Action) {
        self.submitAction = action
    }
}

// MARK: - Internal tools
private extension MorningBearUITextField {
    func designTextField() {
        // Set border
        self.layer.cornerRadius = 12
        self.layer.borderColor = MorningBearUIAsset.Colors.gray500.color.cgColor
        self.layer.borderWidth = 1
        
        // Set background
        self.backgroundColor = .clear
        
        // Set content configs
        self.textColor = MorningBearUIAsset.Colors.gray50.color
        self.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 16)
        self.addLeftPadding()
    }
}

fileprivate extension UITextField {
    func addLeftPadding() {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 12, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = ViewMode.always
    }
}
