//
//  MorningBearUIDateTextField.swift
//  MorningBearUI
//
//  Created by Young Bin on 2023/01/04.
//  Copyright © 2023 com.dache. All rights reserved.
//


import UIKit

import RxSwift
import RxCocoa

/// 앱 전반에 걸쳐 사용되는 데이트 피커 텍스트 필드
///
/// `MorningBearUITextField`를 상속해서 사용. 디자인 요소는 이미 `MorningBearUITextField`에서 다 끝냈으므로
/// 데이트 피커만 잘 더해서 사용하면 된다.
public class MorningBearUIDateTextField: MorningBearUITextField {
    private let datePicker = UIDatePicker()
    private let dateFormatter = DateFormatter()
    private let bag = DisposeBag()
    
    public override func awakeFromNib() {
        super.awakeFromNib()
        
        configureDatePicker()
        combineDatePickerWithTextField()
        
        dateFormatter.dateFormat = "a hh시 mm분"
    }
}

private extension MorningBearUIDateTextField {
    func configureDatePicker() {
        datePicker.datePickerMode = .time // 시간만 나오게
        datePicker.preferredDatePickerStyle = .wheels
    }
    
    func combineDatePickerWithTextField() {
        self.inputView = datePicker
        self.inputAccessoryView = UIToolbar().addDoneButton(with: bag) { [weak self] in
            guard let self else { return }
            
            let date = self.datePicker.date
            let dateString = self.dateFormatter.string(from: date)

            self.text = dateString
            self.resignFirstResponder()
        }
    }
}

fileprivate extension UIToolbar {
    typealias Action = () -> Void
    
    /// 데이트피커 같은 데에 `done` 버튼 달고싶을 때 사용함
    func addDoneButton(with bag: DisposeBag, action: Action?) -> UIToolbar {
        let toolBar = self
        
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "완료")
        if let action {
            doneButton.rx.tap.bind {
                action()
            }
            .disposed(by: bag)
        }
        
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
}

