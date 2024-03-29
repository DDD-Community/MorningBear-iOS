//
//  SetGoalViewController.swift
//  MorningBear
//
//  Created by 이건우 on 2023/01/20.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

import RxSwift
import RxCocoa

class SetGoalViewController: UIViewController {
    
    private let bag = DisposeBag()
    var viewModel: InitialInfoViewModel!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
            titleLabel.textColor = .white
            titleLabel.text = "이루고 싶은 목표가 있나요?"
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 16)
            descriptionLabel.textColor = MorningBearUIAsset.Colors.disabledText.color
            descriptionLabel.text = "미라클 모닝 시작하기 전, 짧은 목표를 설정해 주세요"
        }
    }
    @IBOutlet weak var goalTextField: MorningBearUITextField! {
        didSet {
            goalTextField.placeholder = "이루고자 하는 결심을 입력해 주세요"
            goalTextField.addTarget(self, action: #selector(self.textFieldIsEditing(_:)), for: .editingChanged)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
      
        setDelegate()
        
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
    }
    
    private func setDelegate() {
        goalTextField.delegate = self
    }
    
    @objc func textFieldIsEditing(_ sender: Any?) {
        var value = viewModel.canGoNext.value
        
        if goalTextField.text == "" {
            value[viewModel.currentIndex.value] = false
            viewModel.canGoNext.accept(value)
        } else {
            value[viewModel.currentIndex.value] = true
            viewModel.canGoNext.accept(value)
        }
    }
}

extension SetGoalViewController: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        let maxLength = 12
        
        if let char = string.cString(using: String.Encoding.utf8) {
            let isBackSpace = strcmp(char, "\\b")
            if isBackSpace == -92 {
                return true
            }
        }
        guard textField.text!.count < maxLength else { return false }
        return true
    }
}
