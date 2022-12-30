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

class AuthViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var kakaoLoginButton: UIButton!
    @IBOutlet weak var appleLoginButton: UIButton!
    
    // MARK: - Variables
    private let kakaoLoginManager: KakaoLoginManager = KakaoLoginManager()
    private let appleLoginManager: AppleLoginManager = AppleLoginManager()
    
    // MARK: - LifeCycles
    override func viewDidLoad() {
        
    }
    
    // MARK: - IBACtions
    @IBAction func kakaoLoginButtonTapped(_ sender: Any) {
         appleLoginManager.login()
    }
    
    @IBAction func appleLoginButtonTapped(_ sender: Any) {
         kakaoLoginManager.login()
    }
}
