//
//  AppleLoginManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import RxSwift
import AuthenticationServices

public final class AppleLoginManager {
    public var delegate: ASAuthorizationControllerDelegate!
    
    private let authManager: MorningBearAuthManager = .shared
    private let tokenManager: TokenManager
    
    public func login(contextProvider: ASAuthorizationControllerPresentationContextProviding) {
        let request = ASAuthorizationAppleIDProvider().createRequest()
        request.requestedScopes = [.email]
        
        let controller = ASAuthorizationController(authorizationRequests: [request])
        controller.delegate = delegate
        controller.presentationContextProvider = contextProvider
        controller.performRequests()
    }
    
    func handleLoginResult(appleIDCredential: ASAuthorizationAppleIDCredential) -> Single<String?> {
        let userIdentifier = appleIDCredential.user
        guard let idToken = String(data: appleIDCredential.identityToken!, encoding: .utf8) else {
            return .error(TokenError.invalidResponse)
        }
        
        tokenManager.saveAppleUserIdentifierAtLocal(userIdentifier)
        return tokenManager.progressApple(token: idToken)
    }
    
    func checkCredentialState() {
        guard let userIdentifier = AuthUserDefaultsManager.shared.userIdentifier else { return }
        
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
    
    public init() {
        self.tokenManager = TokenManager()
    }
}
