//
//  MorningBearAuthManager.swift
//  MorningBearAuth
//
//  Created by Young Bin on 2023/02/16.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

import MorningBearKit

public final class MorningBearAuthManager {
    public static let shared = MorningBearAuthManager()
    
    private let storage: UserDefaults
    
    @HotBound public private(set) var isLoggedIn: Bool?
    
    init(_ storage: UserDefaults = .standard) {
        self.storage = storage
        
        // FIXME: Debug -> 자동로그인 풀고싶을 떄 사용
        storage.removeObject(forKey: storageTokenKey)
        
        if isTokenAvailable {
            isLoggedIn = true
        } else {
            isLoggedIn = false
        }
    }
}

public extension MorningBearAuthManager {
    func login(token: String) -> Bool {
        guard isLoggedIn == false else {
            return false
        }
        
        self.storage.set(token, forKey: self.storageTokenKey)
        self.isLoggedIn = true
        
        return true
    }
    
    func logout() {
        self.storage.removeObject(forKey: self.storageTokenKey)
        self.isLoggedIn = false
    }
    
    func withdrawal() {
        self.storage.removeObject(forKey: self.storageTokenKey)
        self.isLoggedIn = false
    }
    
    var token: String? {
        storage.string(forKey: self.storageTokenKey)
    }
}

private extension MorningBearAuthManager {
    var storageTokenKey: String { "Token_Key" }
    var isTokenAvailable: Bool { storage.object(forKey: storageTokenKey) != nil }
}


enum AuthError: Error {
    case failToWithdrawal
}
