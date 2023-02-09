//
//  DatePickerViewController.swift
//  MorningBear
//
//  Created by 이건우 on 2023/02/09.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
import MorningBearKit

import PanModal

protocol SendDateDelegate: AnyObject {
    func sendDate(date: String)
}

class DatePickerViewController: UIViewController {
    
    weak var delegate: SendDateDelegate?
    private var date: String?
    
    @IBOutlet weak var datePicker: UIDatePicker! {
        didSet {
            datePicker.locale = Locale(identifier: "ko")
            datePicker.datePickerMode = .time
            datePicker.addTarget(self, action: #selector(dateIsChanged), for: .valueChanged)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        panModalSetNeedsLayoutUpdate()
    }
    
    @objc private func dateIsChanged(_ sender: UIDatePicker) {
        let timeFormatter = MorningBearDateFormatter.datePickerTimeFormatter
        date = timeFormatter.string(from: sender.date)
    }
}

extension DatePickerViewController: PanModalPresentable {
    var panScrollable: UIScrollView? {
        return nil
    }

    var shortFormHeight: PanModalHeight {
        return .contentHeight(220)
    }
    
    var longFormHeight: PanModalHeight {
        return .contentHeight(220)
    }
    
    func panModalWillDismiss() {
        guard let date = date else { return }
        delegate?.sendDate(date: date)
    }
}
