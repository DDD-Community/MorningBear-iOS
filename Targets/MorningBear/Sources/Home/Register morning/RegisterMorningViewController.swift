//
//  RegisterMorningViewController.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/04.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

class RegisterMorningViewController: UIViewController {
    // MARK: Image view
    @IBOutlet weak var morningImageView: UIImageView!
    
    // MARK: Lables
    @IBOutlet weak var categoryLabel: UILabel! {
        didSet {
            categoryLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var startMorningLabel: UILabel!{
        didSet {
            startMorningLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var endMorningLabel: UILabel!{
        didSet {
            endMorningLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    @IBOutlet weak var commentLabel: UILabel!{
        didSet {
            commentLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
        }
    }
    
    // MARK: Text field
    @IBOutlet weak var startTimeTextField: MorningBearUITextField! {
        didSet {
            startTimeTextField.placeholder = "오전 8시 30분"
            startTimeTextField.isEnabled = false
        }
    }
    @IBOutlet weak var endTimeTextField: MorningBearUITextField!{
        didSet {
            endTimeTextField.placeholder = "오전 8시 30분"
            endTimeTextField.isEnabled = false
        }
    }
    
    // MARK: Buttons
    @IBOutlet weak var categoryHelpButton: MorningBearUIIconButton! {
        didSet {
            categoryHelpButton.shape(icon: .questionMark)
        }
    }
    @IBOutlet weak var commentWriteButton: MorningBearUIIconButton! {
        didSet {
            commentWriteButton.shape(icon: .pencil)
        }
    }
    @IBOutlet weak var registerButton: LargeButton!
    
    // MARK: View controller methods
    override func viewDidLoad() {
        super.viewDidLoad()

        designNavigationBar()
    }
}

private extension RegisterMorningViewController {
    func designNavigationBar() {
        navigationItem.title = "오늘의 미라클모닝"
    }
}
