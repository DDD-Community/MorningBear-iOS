//
//  KakaoLoginManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2022/12/06.
//  Copyright © 2022 com.dache. All rights reserved.
//

import RxKakaoSDKUser
import KakaoSDKUser
import RxKakaoSDKAuth
import KakaoSDKAuth
import RxSwift

import MorningBearNetwork
import MorningBearAPI

public final class KakaoLoginManager {
    
    private let bag = DisposeBag()

    public func login() {
        // 카카오톡 앱 실행 가능 여부 확인
        if (UserApi.isKakaoTalkLoginAvailable()) {
            UserApi.shared.rx.loginWithKakaoTalk()
                .subscribe(onNext:{ (oauthToken) in
                    print("loginWithKakaoTalk() success.")
                    
                    let accessToken = oauthToken.accessToken
                    TokenManager.encodeToken(state: .kakao, token: accessToken)
                    
                }, onError: {error in
                    print(error)
                })
                .disposed(by: bag)
        }
        
        else {
            print("--->[KakaoLoginManager] 카카오톡 설치 확인 실패, 카카오계정으로 로그인")
            UserApi.shared.rx.loginWithKakaoAccount()
                .subscribe(onNext:{ (oauthToken) in
                    print("loginWithKakaoAccount() success.")
                    
                    let accessToken = oauthToken.accessToken
                    TokenManager.encodeToken(state: .kakao, token: accessToken)
                    
                }, onError: {error in
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
            }, onFailure: {error in
                print(error)
            })
            .disposed(by: bag)
    }
    
    public func verifyToken() {
        // !! has error need to fix
        
        /*
        if (AuthApi.hasToken()) {
            UserApi.shared.rx.accessTokenInfo()
                .subscribe(onSuccess:{ (_) in
                    // 토큰 유효성 체크 성공 (필요 시 토큰 갱신됨)
                }, onFailure: {error in
                    if let sdkError = error as? SdkError, sdkError.isInvalidTokenError() == true {
                        // 로그인 필요
                    }
                    else {
                        // 기타 에러
                    }
                })
                .disposed(by: disposeBag)
        }
        
        else {
         
            // 로그인 필요
        }
        */
    }
    
    public func logout() {
        UserApi.shared.rx.logout()
            .subscribe(onCompleted:{
                print("logout() success.")
            }, onError: {error in
                print(error)
            })
            .disposed(by: bag)
    }
    
    public func deleteUser() {
        UserApi.shared.rx.unlink()
            .subscribe(onCompleted:{
                print("unlink() success.")
            }, onError: {error in
                print(error)
            })
            .disposed(by: bag)
    }
    
    public init() {}
}
