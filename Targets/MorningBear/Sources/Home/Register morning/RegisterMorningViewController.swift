//
//  RegisterMorningViewController.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/04.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa

import MorningBearUI
import MorningBearKit

class RegisterMorningViewController: UIViewController {
    // MARK: - Instance properties
    private let viewModel = RegisterMorningViewModel()
    private let bag = DisposeBag()
    
    
    // MARK: - View components
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
            startTimeTextField.text = "오전 8시 30분"
            startTimeTextField.isUserInteractionEnabled = false
        }
    }
    @IBOutlet weak var endTimeTextField: MorningBearUITextField!{
        didSet {
            endTimeTextField.text = "오전 8시 30분"
            endTimeTextField.isUserInteractionEnabled = false

        }
    }
    @IBOutlet weak var commentTextView: MorningBearUITextView! {
        didSet {
            commentTextView.textContainer.maximumNumberOfLines = 6
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
        
        bindButtons()
    }
}

// MARK: Related to view
private extension RegisterMorningViewController {
    func designNavigationBar() {
        navigationItem.title = "오늘의 미라클모닝"
    }
    
    func bindButtons() {
        registerButton.rx.tap.bind { [weak self] in
            guard let self else { return }
            
            do {
                let info = try self.convertViewInformation()
                self.viewModel.registerMorningInformation(info: info)
            } catch let error {
                self.showAlert(error)
            }
        }
        .disposed(by: bag)
    }
}

// MARK: Internal tools
private extension RegisterMorningViewController {
    func convertViewInformation() throws -> MorningRegistrationInfo  {
        let formatter = viewModel.timeFormatter
        
        guard let startTimeText = startTimeTextField.text,
              let endTimeText = endTimeTextField.text
        else {
            throw MorningBearDateFormatterError.emptyString
        }
        
        guard let startTime = formatter.date(from: startTimeText),
              let endTime = formatter.date(from: endTimeText)
        else {
            throw MorningBearDateFormatterError.invalidString
        }
        
        guard let image = morningImageView.image else {
            throw DataError.emptyData
        }
        
        let comment = commentTextView.text ?? ""
        
        return MorningRegistrationInfo(image: image, startTime: startTime, endTime: endTime, comment: comment)
    }
    
    enum DataError: LocalizedError {
        case emptyData
        
        var errorDescription: String? {
            switch self {
            case .emptyData:
                return "데이터 처리 중 오류가 발생했습니다. 다시 시도해주세요."
            }
        }
    }
}
