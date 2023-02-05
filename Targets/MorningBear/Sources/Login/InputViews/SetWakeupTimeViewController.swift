//
//  SetWakeupTimeViewController.swift
//  MorningBear
//
//  Created by 이건우 on 2023/01/20.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

import RxSwift
import RxCocoa

class SetWakeupTimeViewController: UIViewController {
    
    private let bag = DisposeBag()
    var viewModel: InitialInfoViewModel!
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
            titleLabel.textColor = .white
            titleLabel.text = "기상 시간을 알려주세요"
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 16)
            descriptionLabel.textColor = MorningBearUIAsset.Colors.disabledText.color
            descriptionLabel.text = "모너가 대신 깨워드릴게요"
        }
    }
    @IBOutlet weak var timePickerPopUpButton: UIButton! {
        didSet {
            timePickerPopUpButton.layer.cornerRadius = 8
            timePickerPopUpButton.layer.borderColor = MorningBearUIAsset.Colors.gray700.color.cgColor
            timePickerPopUpButton.layer.borderWidth = 1
        }
    }
    @IBOutlet weak var timeLabel: UILabel! {
        didSet {
            timeLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 16)
            timeLabel.textColor = MorningBearUIAsset.Colors.gray700.color
            timeLabel.text = "오전  5 : 00"
        }
    }
    @IBOutlet weak var downArrowImage: UIImageView! {
        didSet {
            downArrowImage.image = MorningBearUIAsset.Images.arrowDecrease.image
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindButton()
    }
    
    private func bindButton() {
        timePickerPopUpButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
               // TODO: picker view with half modal
            }
            .disposed(by: bag)
    }
}
