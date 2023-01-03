//
//  AuthViewController.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit
import AuthenticationServices
import MorningBearKit

import RxSwift
import RxCocoa

class AuthViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var kakaoLoginButton: UIButton! {
        didSet {
            kakaoLoginButton.setTitle("kakao", for: .normal)
        }
    }
    @IBOutlet weak var appleLoginButton: UIButton! {
        didSet {
            appleLoginButton.setTitle("apple", for: .normal)
        }
    }
    
    // MARK: - Variables
    private let kakaoLoginManager: KakaoLoginManager = KakaoLoginManager()
    private let appleLoginManager: AppleLoginManager = AppleLoginManager()
    
    private let bag = DisposeBag()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        bindButtons()
    }
    
    // MARK: - Functions
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
