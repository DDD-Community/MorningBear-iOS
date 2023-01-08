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
    private var morningImage: UIImage?
    @IBOutlet weak var morningImageView: UIImageView! {
        didSet {
            morningImageView.layer.cornerRadius = 8
        }
    }
    
    @IBOutlet weak var dateLabel: UILabel! {
        didSet {
            dateLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
            dateLabel.text = viewModel.currentTimeString
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 40)
            timeLabel.text = viewModel.currentTimeString
        }
    }
    
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
            startTimeTextField.text = viewModel.currentTimeString
            startTimeTextField.isUserInteractionEnabled = false
        }
    }
    @IBOutlet weak var endTimeTextField: MorningBearUITextField!{
        didSet {
            endTimeTextField.text = viewModel.currentTimeString
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
        
        
        if let morningImage {
            self.morningImageView.image = morningImage
        } else {
            let largeConfig = UIImage.SymbolConfiguration(pointSize: 200, weight: .regular, scale: .large)

            let placeholderImage = UIImage(systemName: "xmark.circle", withConfiguration: largeConfig)!
                .withTintColor(.black, renderingMode: .alwaysOriginal)
            
            self.morningImageView.image = placeholderImage
            self.morningImageView.contentMode = .center
        }
        
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
