//
//  Profile.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/02/01.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import MorningBearAPI

public struct Profile {
    private let id = UUID()
    
    public let image: UIImage
//    public let imageURL: URL
    public let nickname: String
    
    public let countContext: CountContext?
    public let buttonContext: ButtonContext?
}

// MARK: Initializers
public extension Profile {
    public init(image: UIImage, nickname: String, counts: CountContext) {
        self.image = image
        self.nickname = nickname
        self.countContext = counts
        
        self.buttonContext = nil
    }
    
    public init(image: UIImage, nickname: String, buttonText: ButtonContext) {
        self.image = image
        self.nickname = nickname
        self.buttonContext = buttonText
        
        self.countContext = nil
    }
}

public extension Profile {
    struct CountContext {
        public let postCount: Int
        public let supportCount: Int
        public let badgeCount: Int
        
        public init(postCount: Int, supportCount: Int, badgeCount: Int) {
            self.postCount = postCount
            self.supportCount = supportCount
            self.badgeCount = badgeCount
        }
    }
    
    struct ButtonContext {
        public let buttonText: String
        public let buttonAction: () -> Void
        
        public init(buttonText: String, buttonAction: @escaping () -> Void) {
            self.buttonText = buttonText
            self.buttonAction = buttonAction
        }
    }
}

extension Profile: Hashable {
    public static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
