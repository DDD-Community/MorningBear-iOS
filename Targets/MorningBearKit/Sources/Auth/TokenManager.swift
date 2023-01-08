//
//  TokenManager.swift
//  MorningBearKit
//
//  Created by 이건우 on 2023/01/02.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import MorningBearNetwork
import MorningBearAPI
import KakaoSDKAuth

public final class TokenManager {
    
    public enum AuthState: String {
        case kakao
        case apple
    }
    
    public var hasMorningBearToken: Bool {
        return UserDefaultsManager.shared.morningBearToken != nil
    }
    
    /// Apple 로그인 후 엑세스 토큰에 필요한 프로세스를 진행합니다
    ///
    /// Apple 엑세스 토큰을 앱에서 사용되는 토큰으로 인코딩 후, UserDefault에 저장
    public func progressApple(token: String) {
        Network.shared.apollo
            .fetch(query: EncodeQuery(state: GraphQLNullable(stringLiteral: AuthState.apple.rawValue), token: GraphQLNullable(stringLiteral: token))) { result in
            switch result {
            case .success(let graphQLResult):
                guard let encodedToken = graphQLResult.data?.encode else { return }
                
                print("encodedToken is", encodedToken)
                self.saveAuthStateAtLocal(.apple)
                self.saveMorningBearTokenAtLocal(encodedToken)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// Kakao 로그인 후 엑세스 토큰에 필요한 프로세스를 진행합니다
    ///
    /// Kakao 엑세스 토큰을 앱에서 사용되는 토큰으로 인코딩 후, UserDefault에 저장.  만료일과 리프레시 토큰 또한 UserDefault에 별도로 저장
    public func progressKakao(oauthToken: OAuthToken) {
        Network.shared.apollo
            .fetch(query: EncodeQuery(state: GraphQLNullable(stringLiteral: AuthState.kakao.rawValue), token: GraphQLNullable(stringLiteral: oauthToken.accessToken))) { result in
            switch result {
            case .success(let graphQLResult):
                guard let encodedToken = graphQLResult.data?.encode else { return }
                
                print("encodedToken is", encodedToken)
                self.saveAuthStateAtLocal(.kakao)
                self.saveMorningBearTokenAtLocal(encodedToken)
                self.saveRefreshTokenAtLocal(oauthToken.refreshToken)
                self.saveExpirationDateAtLocal(oauthToken.expiredAt)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    /// 로그인 시 사용한 서비스명을 로컬에 저장 (apple, kakao)
    private func saveAuthStateAtLocal(_ state: AuthState) {
        UserDefaultsManager.shared.authState = state.rawValue
    }
    
    /// 로그인 시 사용한 서비스명을 로컬에서 삭제 (apple, kakao)
    private func removeAuthStateAtLocal() {
        UserDefaultsManager.shared.authState = nil
    }
    
    /// MorningBear token을 로컬에 저장
    private func saveMorningBearTokenAtLocal(_ token: String) {
        UserDefaultsManager.shared.morningBearToken = token
    }
    
    /// MorningBear token을 로컬에서 삭제
    func removeMorningBearTokenAtLocal() {
        UserDefaultsManager.shared.morningBearToken = nil
    }
    
    /// 로그아웃 혹은 회원탈퇴시 인증과 관련된 모든 토큰 및 데이터를 로컬에서 삭제
    func removeAll() {
        removeAuthStateAtLocal()
        removeMorningBearTokenAtLocal()
        removeUserIdentifierAtLocal()
        removeRefreshTokenAtLocal()
        removeExpirationDateAtLocal()
    }
    
    // MARK: - Only for Apple
    /// UserDefaultManager를 통해 kakao refresh token 저장
    func saveUserIdentifierAtLocal(_ uid: String) {
        UserDefaultsManager.shared.userIdentifier = uid
    }
    
    /// UserDefaultManager를 통해 kakao refresh token 저장
    func removeUserIdentifierAtLocal() {
        UserDefaultsManager.shared.userIdentifier = nil
    }
    
    // MARK: - Only For Kakao
    /// UserDefaultManager를 통해 kakao refresh token 저장
    private func saveRefreshTokenAtLocal(_ token: String) {
        UserDefaultsManager.shared.refreshToken = token
    }
    
    /// UserDefaultManager를 통해 kakao refresh token 저장
    func removeRefreshTokenAtLocal() {
        UserDefaultsManager.shared.refreshToken = nil
    }
    
    /// UserDefaultManager를 통해 kakao access token 만료일 저장
    private func saveExpirationDateAtLocal(_ date: Date) {
        UserDefaultsManager.shared.expirationDate = date
    }
    
    /// UserDefaultManager를 통해 kakao access token 만료일 삭제
    func removeExpirationDateAtLocal() {
        UserDefaultsManager.shared.expirationDate = nil
    }
}
