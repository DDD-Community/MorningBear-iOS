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
    @Bound var isNetworking = false
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView! {
        didSet {
            activityIndicator.isHidden = true
        }
    }
    
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
        bindObservables()
        
        appleLoginManager.delegate = self
    }
    
    private func configureView() {
        self.view.backgroundColor = MorningBearUIAsset.Colors.primaryBackground.color
    }
    
    private func bindObservables() {
        $isNetworking.asDriver(onErrorJustReturn: false)
            .drive(onNext: { [weak self] value in
                guard let self else { return }
                
                if value {
                    // Now networking
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                    self.kakaoLoginButton.isEnabled = false
                    self.appleLoginButton.isEnabled = false
                } else {
                    // Prepare networking
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                    self.kakaoLoginButton.isEnabled = true
                    self.appleLoginButton.isEnabled = true
                }
            })
            .disposed(by: bag)
    }
    
    private func bindButtons() {
        kakaoLoginButton.rx.tap
            .withUnretained(self)
            .bind { weakSelf, _ in
                weakSelf.isNetworking = true

                weakSelf.handleTokenObservable(
                    weakSelf.kakaoLoginManager.login
                )
            }
            .disposed(by: bag)
        
        appleLoginButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                self.appleLoginManager.login(contextProvider: self)
            }
            .disposed(by: bag)
    }
    
    private func handleTokenObservable(_ tokenObservable: Observable<String?>) {
        return tokenObservable
            .asDriver(onErrorJustReturn: nil)
            .debug()
            .drive(onNext: { [weak self] token in
                guard let self else {
                    return
                }
                
                if let token = token, self.appAuthManager.login(token: token) {
                    // 성공하면 다음 화면으로 push
                    // TODO: (회원가입 여부 판단해서 온보딩으로 넘기기)
                    // RootViewController에서 처리해도 됨
                } else {
                    // 실패하면 경고
                    self.showAlert(LoginError.failToLogin)
                }
                
                self.isNetworking = false
            })
            .disposed(by: bag)
    }
}

extension LoginViewController: ASAuthorizationControllerDelegate {
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            
            let userIdentifier = appleIDCredential.user //userIdentifier
            handleTokenObservable(Observable.of(userIdentifier))
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        self.showAlert(error)
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
