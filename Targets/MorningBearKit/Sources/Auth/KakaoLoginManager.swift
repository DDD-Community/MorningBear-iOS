//
//  KakaoLoginManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/06.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation
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
    
    public func login() {
        // 카카오톡 앱 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext:{ [weak self] oauthToken in
                    guard let self = self else { return }
                    
                    print("loginWithKakaoTalk() success.")
                    self.tokenManager.progressKakao(oauthToken: oauthToken)
                    
                }, onError: { error in
                    print(error)
                })
                .disposed(by: bag)
        }
        
        else {
            print("--->[KakaoLoginManager] 카카오톡 설치 확인 실패, 카카오계정으로 로그인")
            UserApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext:{ [weak self] oauthToken in
                    guard let self = self else { return }
                    
                    print("loginWithKakaoAccount() success.")
                    self.tokenManager.progressKakao(oauthToken: oauthToken)
                    
                }, onError: { error in
                    print(error)
                })
                .disposed(by: bag)
        }
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
                self.tokenManager.removeAll()
                
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
                self.tokenManager.removeAll()
                
                print("unlink() success.")
            }, onError: { error in
                print(error)
            })
            .disposed(by: bag)
    }
    
    public init() {
        self.tokenManager = TokenManager()
    }
}
