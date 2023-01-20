//
//  SetProfileViewController.swift
//  MorningBear
//
//  Created by 이건우 on 2023/01/20.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit
import MorningBearUI

import RxSwift
import RxCocoa

class SetProfileViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 24)
            titleLabel.textColor = .white
            titleLabel.text = "프로필을 설정해 주세요"
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 16)
            descriptionLabel.textColor = MorningBearUIAsset.Colors.disabledText.color
            descriptionLabel.text = "나를 잘 보여주는 사진과 닉네임을 작성해 주세요"
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
