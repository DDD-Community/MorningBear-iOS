//
//  TokenManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2023/01/02.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import RxSwift
import KakaoSDKAuth

import MorningBearNetwork
import MorningBearAPI

public final class TokenManager {
    
    public enum AuthState: String {
        case kakao
        case apple
    }
    
    public var hasMorningBearToken: Bool {
        return AuthUserDefaultsManager.shared.morningBearToken != nil
    }
    
    /// Apple 로그인 후 엑세스 토큰에 필요한 프로세스를 진행합니다
    ///
    /// Apple 엑세스 토큰을 앱에서 사용되는 토큰으로 인코딩 후, UserDefault에 저장
    public func progressApple(token: String) -> Single<String?> {
        Network.shared.apollo.rx.fetch(
            query: EncodeQuery(
                state: .some(AuthState.apple.rawValue),
                token: .some(token)
            ))
        .map { graphQLResult -> String? in
            guard let encodedToken = graphQLResult.data?.encode else {
                throw TokenError.invalidResponse
            }
            
            print("encodedToken is", encodedToken)
            
            self.saveAuthStateAtLocal(.apple)
            self.saveMorningBearTokenAtLocal(encodedToken)
            
            return encodedToken
        }
    }
    
    /// Kakao 로그인 후 엑세스 토큰에 필요한 프로세스를 진행합니다
    ///
    /// Kakao 엑세스 토큰을 앱에서 사용되는 토큰으로 인코딩 후, UserDefault에 저장.  만료일과 리프레시 토큰 또한 UserDefault에 별도로 저장
    public func progressKakao(oauthToken: OAuthToken) -> Single<String?> {
        Network.shared.apollo.rx.fetch(
            query: EncodeQuery(
                state: .some(AuthState.kakao.rawValue),
                token: .some(oauthToken.accessToken)
            )
        )
        .map { graphQLResult -> String? in
            guard let encodedToken = graphQLResult.data?.encode else {
                return nil
            }
            
            print("encodedToken is", encodedToken)
            
            self.saveAuthStateAtLocal(.kakao)
            self.saveMorningBearTokenAtLocal(encodedToken)
            self.saveKakaoRefreshTokenAtLocal(oauthToken.refreshToken)
            self.saveKakaoExpirationDateAtLocal(oauthToken.expiredAt)
            
            return encodedToken
        }
    }
    
    /// 로그인 시 사용한 서비스명을 로컬에 저장 (apple, kakao)
    private func saveAuthStateAtLocal(_ state: AuthState) {
        AuthUserDefaultsManager.shared.authState = state.rawValue
    }
    
    /// 로그인 시 사용한 서비스명을 로컬에서 삭제 (apple, kakao)
    private func removeAuthStateAtLocal() {
        AuthUserDefaultsManager.shared.authState = nil
    }
    
    /// MorningBear token을 로컬에 저장
    private func saveMorningBearTokenAtLocal(_ token: String) {
        AuthUserDefaultsManager.shared.morningBearToken = token
    }
    
    /// MorningBear token을 로컬에서 삭제
    func removeMorningBearTokenAtLocal() {
        AuthUserDefaultsManager.shared.morningBearToken = nil
    }
    
    /// 로그아웃 혹은 회원탈퇴시 인증과 관련된 모든 토큰 및 데이터를 로컬에서 삭제
    func removeAllAuthorizationData() {
        removeAuthStateAtLocal()
        removeMorningBearTokenAtLocal()
        removeAppleUserIdentifierAtLocal()
        removeKakaoRefreshTokenAtLocal()
        removeKakaoExpirationDateAtLocal()
    }
    
    // MARK: - Only for Apple
    /// UserDefaultManager를 통해 apple의 userIdentifier 값을 로컬에 저장
    func saveAppleUserIdentifierAtLocal(_ uid: String) {
        AuthUserDefaultsManager.shared.userIdentifier = uid
    }
    
    /// UserDefaultManager를 통해 apple의 userIdentifier 값을 로컬에서 삭제
    func removeAppleUserIdentifierAtLocal() {
        AuthUserDefaultsManager.shared.userIdentifier = nil
    }
    
    // MARK: - Only For Kakao
    /// UserDefaultManager를 통해 kakao refresh token 저장
    private func saveKakaoRefreshTokenAtLocal(_ token: String) {
        AuthUserDefaultsManager.shared.refreshToken = token
    }
    
    /// UserDefaultManager를 통해 kakao refresh token 삭제
    func removeKakaoRefreshTokenAtLocal() {
        AuthUserDefaultsManager.shared.refreshToken = nil
    }
    
    /// UserDefaultManager를 통해 kakao access token 만료일 저장
    private func saveKakaoExpirationDateAtLocal(_ date: Date) {
        AuthUserDefaultsManager.shared.expirationDate = date
    }
    
    /// UserDefaultManager를 통해 kakao access token 만료일 삭제
    func removeKakaoExpirationDateAtLocal() {
        AuthUserDefaultsManager.shared.expirationDate = nil
    }
}

enum TokenError: Error {
    case invalidResponse
}
