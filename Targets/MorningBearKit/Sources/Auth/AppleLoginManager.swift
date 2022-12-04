//
//  AppleLoginManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import AuthenticationServices

class AppleLoginManager {
    
    static var userID: String?
    
    static func request(_ delegate: ASAuthorizationControllerDelegate) {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = delegate
        authorizationController.performRequests()
    }
    
    static func checkCredentialState() {
        guard userID != nil else { return }
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userID!) { credentialState, error in
            switch credentialState {
            case .authorized:
                print("The Apple ID credential is valid.")
                break
            case .revoked:
                print("The Apple ID credential is revoked.")
                break
            case .notFound:
                print("No credential was found, so need to show the sign-in UI.")
            default:
                break
            }
        }
    }
}
