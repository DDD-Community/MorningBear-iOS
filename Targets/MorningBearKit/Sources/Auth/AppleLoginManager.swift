//
//  AppleLoginManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import AuthenticationServices

public final class AppleLoginManager: NSObject {
    
    public weak var viewController: UIViewController?
    public var userIdentifier: String?
    
    public func login() {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email]
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = self
        controller.presentationContextProvider = self
        controller.performRequests()
    }
    
    public func checkCredentialState() {
        guard userIdentifier != nil else { return }
        
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        appleIDProvider.getCredentialState(forUserID: userIdentifier!) { credentialState, error in
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
    
    public override init() {}
}

extension AppleLoginManager: ASAuthorizationControllerPresentationContextProviding {
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return viewController!.view.window!
    }
}

extension AppleLoginManager: ASAuthorizationControllerDelegate {
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as? ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let email = appleIDCredential.email
            let idToken = String(data: appleIDCredential.identityToken!, encoding: .utf8)
            
            // TODO: Save userIdentifier at UserDefault for checking credential state
            self.userIdentifier = userIdentifier
            
            print("User id is \(userIdentifier) \n Email is \(String(describing: email)) \n ID token is \(idToken ?? "")")
        }
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        print("AppleLoginError!", error.localizedDescription)
    }
}
