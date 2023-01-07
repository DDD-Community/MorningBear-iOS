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
    private var morningImage: UIImage!
    
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
    
    // MARK: - View controller methods
    override func viewDidLoad() {
        super.viewDidLoad()

        designNavigationBar()
        
        self.morningImageView.image = morningImage
        
        bindButtons()
    }
}

extension RegisterMorningViewController {
    func prepare(_ image: UIImage) {
        self.morningImage = image
    }
}

private extension RegisterMorningViewController {
    func designNavigationBar() {
        navigationItem.title = "오늘의 미라클모닝"
    }
    
    func bindButtons() {
        registerButton.rx.tap.bind { [weak self] in
            guard let self else { return }
            
            do {
                guard let startTimeText = self.startTimeTextField.text,
                      let endTimeText = self.endTimeTextField.text
                else {
                    throw RegisterMorningViewModel.DataError.emptyData
                }
                
                guard let image = self.morningImageView.image else {
                    throw RegisterMorningViewModel.DataError.emptyData
                }
                
                let commentText = self.commentTextView.text ?? ""
                
                let info = try self.viewModel.convertViewContentToInformation(image,
                                                                              startTimeText,
                                                                              endTimeText,
                                                                              commentText)
                
                self.viewModel.registerMorningInformation(info: info)
            } catch let error {
                self.showAlert(error)
            }
        }
        .disposed(by: bag)
    }
}
