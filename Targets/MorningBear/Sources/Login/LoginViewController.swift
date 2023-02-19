//
//  LoginViewController.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit
import AuthenticationServices

import MorningBearAuth
import MorningBearKit
import MorningBearUI

import RxSwift
import RxCocoa

class LoginViewController: UIViewController {
    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.image = MorningBearUIAsset.Images.logo.image
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
            kakaoLoginButton.setImage(MorningBearUIAsset.Images.kakaoButton.image, for: .normal)
        }
    }
    
    @IBOutlet weak var appleLoginButton: UIButton! {
        didSet {
            appleLoginButton.setImage(MorningBearUIAsset.Images.appleButton.image, for: .normal)
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
    private let appAuthManager: MorningBearAuthManager = .shared
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        configureView()
        bindButtons()
    }
    
    private func configureView() {
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
    }
    
    private func bindButtons() {
        kakaoLoginButton.rx.tap
            .bind { [weak self] _ in
                guard let self else { return }
                self.processLogin(self.kakaoLoginManager.login)
            }
            .disposed(by: bag)
        
        appleLoginButton.rx.tap.bind { [weak self] _ in
            guard let self = self else { return }
            
            self.appleLoginManager.login(presentWindow: self)
        }
        .disposed(by: bag)
    }
    
    private func processLogin(_ loginTrait: Observable<String?>) {
        loginTrait.subscribe(
            onNext: { [weak self] token in
                guard let self else {
                    return
                }
                
                guard let token = token else {
                    self.showAlert(LoginError.failToLogin)
                    return
                }
                
                if self.appAuthManager.login(token: token) == false {
                    // 실패하면 경고
                    self.showAlert(LoginError.failToLogin)
                } else {
                    // 성공하면 다음 화면으로 push
                    // TODO: (회원가입 여부 판단해서 온보딩으로 넘기기)
                    // RootViewController에서 처리해도 됨
                }
            },
            onError: { error in
                self.showAlert(error)
            })
        .disposed(by: bag)
    }
}

extension LoginViewController: ASAuthorizationControllerPresentationContextProviding {
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
}

enum LoginError: LocalizedError {
    case failToLogin
    
    var errorDescription: String? {
        switch self {
        case .failToLogin:
            return "로그인에 실패했습니다. 다시 시도해주세요!"
        }
    }
}
