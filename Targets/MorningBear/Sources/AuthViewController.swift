//
//  AuthViewController.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import UIKit
import AuthenticationServices

class AuthViewController: UIViewController {
    
    override func viewDidLoad() {
        AppleLoginManager.request(self)
    }
}

extension AuthViewController: ASAuthorizationControllerPresentationContextProviding, ASAuthorizationControllerDelegate {
    
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }

    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let email = appleIDCredential.email
            let idToken = appleIDCredential.identityToken!
            let tokenStr = String(data: idToken, encoding: .utf8)
            
            AppleLoginManager.userID = userIdentifier
            print("User id is \(userIdentifier) \n Email is \(String(describing: email)) \n ID token is \(tokenStr ?? "")")
        }
    }
    
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("AppleLoginError!", error.localizedDescription)
    }
}
