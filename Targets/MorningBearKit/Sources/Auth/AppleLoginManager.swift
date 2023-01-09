//
//  AppleLoginManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import AuthenticationServices

public final class AppleLoginManager: NSObject {
    private let tokenManager: TokenManager
    
    public func login(presentWindow presentationContextProvider: ASAuthorizationControllerPresentationContextProviding) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = presentationContextProvider
        controller.performRequests()
    }
    
    public func checkCredentialState() {
        guard let userIdentifier = UserDefaultsManager.shared.userIdentifier else { return }
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userIdentifier) { credentialState, error in
            switch credentialState {
            case .authorized:
                print("The Apple ID credential is valid.")
                break
            case .revoked:
                print("The Apple ID credential is revoked. need logout progress.")
                break
            case .notFound:
                print("User identifier value is wrong or Apple login system has a problem.")
            default:
                break
            }
        }
    }
    
    public override init() {
        self.tokenManager = TokenManager()
    }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let email = appleIDCredential.email
            guard let idToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) else { return }
            
            print("User id is \(userIdentifier) \n Email is \(String(describing: email)) \n ID token is \(idToken)")
            tokenManager.saveUserIdentifierAtLocal(userIdentifier)
            tokenManager.progressApple(token: idToken)
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("AppleLoginError!", error.localizedDescription)
    }
}
