//
//  LoginViewController.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit
import AuthenticationServices
import MorningBearKit
import MorningBearUI

import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.image = MorningBearUIAsset.Asset.logo.image
        }
    }
    
    @IBOutlet weak var sloganLabel: UILabel! {
        didSet {
            sloganLabel.font = MorningBearUIFontFamily.Pretendard.bold.font(size: 16)
            sloganLabel.textColor = MorningBearUIAsset.Colors.captionText.color
            sloganLabel.text = "아침이 모여 결실까지"
        }
    }
    
    @IBOutlet weak var kakaoLoginButton: UIButton! {
        didSet {
            kakaoLoginButton.setImage(MorningBearUIAsset.Asset.kakaoButton.image, for: .normal)
        }
    }
    
    @IBOutlet weak var appleLoginButton: UIButton! {
        didSet {
            appleLoginButton.setImage(MorningBearUIAsset.Asset.appleButton.image, for: .normal)
        }
    }
    
    @IBOutlet weak var termsOfUseDescriptionLabel: UILabel! {
        didSet {
            termsOfUseDescriptionLabel.font = MorningBearUIFontFamily.Pretendard.regular.font(size: 12)
            termsOfUseDescriptionLabel.textColor = MorningBearUIAsset.Colors.disabledText.color
            termsOfUseDescriptionLabel.text = "서비스 시작시 이용약관 및 개인정보 처리 방침 동의로 간주합니다."
        }
    }
    
    private let kakaoLoginManager: KakaoLoginManager = KakaoLoginManager()
    private let appleLoginManager: AppleLoginManager = AppleLoginManager()
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        configureView()
        bindButtons()
    }
    
    private func configureView() {
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
    }
    
    private func bindButtons() {
        kakaoLoginButton.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            self.kakaoLoginManager.login()
        }
        .disposed(by: bag)
        
        appleLoginButton.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            self.appleLoginManager.login()
        }
        .disposed(by: bag)
    }
}
