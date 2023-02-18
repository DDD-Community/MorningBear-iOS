//
//  KakaoLoginManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/06.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

import RxKakaoSDKCommon
import RxKakaoSDKUser
import KakaoSDKUser
import RxKakaoSDKAuth
import KakaoSDKAuth

import RxSwift

import MorningBearNetwork
import MorningBearAPI

public final class KakaoLoginManager {
    
    private let tokenManager: TokenManager
    private let bag = DisposeBag()
    
    public func login() -> Maybe<String?> {
        let loginObservable: Observable<OAuthToken>
        // 카카오톡 앱 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            loginObservable = UserApi.shared.rx.loginWithKakaoTalk()
        } else {
            loginObservable = UserApi.shared.rx.loginWithKakaoAccount()
        }
        
        let encodedTokenResult: Maybe<String?> = loginObservable
            .withUnretained(self)
            .flatMap { weakSelf, oauthToken in
                weakSelf.tokenManager.progressKakao(oauthToken: oauthToken)
            }
            .asMaybe()
        
        return encodedTokenResult
    }
    
    public func setUserInfo() {
        UserApi.shared.rx.me()
            .subscribe (onSuccess:{ user in
                print("me() success.")
                
                //do something
                _ = user
            }, onFailure: { error in
                print(error)
            })
            .disposed(by: bag)
    }
    
    public func logout() {
        UserApi.shared.rx.logout()
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.tokenManager.removeAllAuthorizationData()
                
                print("logout() success.")
            }, onError: {error in
                print(error)
            })
            .disposed(by: bag)
    }
    
    public func deleteUser() {
        UserApi.shared.rx.unlink()
            .subscribe(onCompleted: { [weak self] in
                guard let self = self else { return }
                self.tokenManager.removeAllAuthorizationData()
                
                print("unlink() success.")
            }, onError: { error in
                print(error)
            })
            .disposed(by: bag)
    }
    
    public init() {
        self.tokenManager = TokenManager()
        
        let KAKAO_APP_KEY: String = "338eeb478a5cce01fe713b9100d0f42e"
        RxKakaoSDK.initSDK(appKey: KAKAO_APP_KEY)
    }
}
