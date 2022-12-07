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
    
    private let appleLoginManager: AppleLoginManager = AppleLoginManager()
    private let kakaoLoginManager: KakaoLoginManager = KakaoLoginManager()
    
    override func viewDidLoad() {
        // appleLoginManager.request()
        // kakaoLoginManager.login()
    }
}
