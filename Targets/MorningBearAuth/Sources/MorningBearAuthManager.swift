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
    private let semaphore: DispatchSemaphore
    
    @ColdBound public private(set) var isLoggedIn: Bool = false
    
    init(_ storage: UserDefaults = .standard) {
        self.storage = storage
        self.semaphore = DispatchSemaphore(value: 1)
    }
}

public extension MorningBearAuthManager {
    func login(token: String) {
        DispatchQueue.global().async {
            self.semaphore.wait()
            defer {
                self.semaphore.signal()
            }
            
            self.storage.set(token, forKey: self.storageTokenKey)
            self.isLoggedIn = true
        }
    }
    
    func logout() {
        DispatchQueue.global().async {
            self.semaphore.wait()
            defer {
                self.semaphore.signal()
            }
            
            self.storage.removeObject(forKey: self.storageTokenKey)
            self.isLoggedIn = false
        }
    }
    
    func withdrawal() {
        DispatchQueue.global().async {
            self.semaphore.wait()
            defer {
                self.semaphore.signal()
            }
            
            self.storage.removeObject(forKey: self.storageTokenKey)
            self.isLoggedIn = false
        }
    }
    
    var token: String? {
        storage.string(forKey: self.storageTokenKey)
    }
}

private extension MorningBearAuthManager {
    var storageTokenKey: String { "Token_Key" }
}


enum AuthError: Error {
    case failToWithdrawal
}
