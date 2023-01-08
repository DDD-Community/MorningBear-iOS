//
//  UserDefaultsManager.swift
//  MorningBearUITests
//
//  Created by 이건우 on 2023/01/07.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public class UserDefaultsManager {
    
    public static let shared: UserDefaultsManager = UserDefaultsManager()
    private let defaults = UserDefaults.standard
    
    /// key값을 enum으로 래핑해서 사용, 필요한 key값이 늘어나면 따로 추가할 예정
    private enum UserDefaultsKey: String {
        case authState
        case morningBearToken
        case refreshToken
        case expirationDate
        case userIdentifier
    }
    
    /// 현재 로그인 되어있는 서비스를 의미합니다. apple or kakao
    var authState: String? {
        set { defaults.setValue(newValue, forKey: UserDefaultsKey.authState.rawValue) }
        get { defaults.string(forKey: UserDefaultsKey.authState.rawValue) }
    }
    
    /// MorningBear앱 내에서 사용되는 식별 토큰입니다
    var morningBearToken: String? {
        set { defaults.setValue(newValue, forKey: UserDefaultsKey.morningBearToken.rawValue) }
        get { defaults.string(forKey: UserDefaultsKey.morningBearToken.rawValue) }
    }
    
    /// apple을 통해 로그인 했을 시 로그인 상태를 체크할 때 필요한 값 입니다
    var userIdentifier: String? {
        set { defaults.setValue(newValue, forKey: UserDefaultsKey.userIdentifier.rawValue) }
        get { defaults.string(forKey: UserDefaultsKey.userIdentifier.rawValue) }
    }
    
    /// kakao를 통해 로그인 했을 시 필요한 refresh token입니다
    var refreshToken: String? {
        set { defaults.setValue(newValue, forKey: UserDefaultsKey.refreshToken.rawValue) }
        get { defaults.string(forKey: UserDefaultsKey.refreshToken.rawValue) }
    }
    
    /// kakao access token이 만료되는 시각입니다.
    var expirationDate: Date? {
        set { defaults.setValue(newValue, forKey: UserDefaultsKey.expirationDate.rawValue) }
        get { defaults.object(forKey: UserDefaultsKey.expirationDate.rawValue) as? Date }
    }
    
    private init() {}
}
