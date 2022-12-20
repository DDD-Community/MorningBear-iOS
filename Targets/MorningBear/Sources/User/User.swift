//
//  User.swift
//  MorningBear
//
//  Created by 이영빈 on 2022/12/08.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

import MorningBearKit

struct User: Codable {
    let id: String
    var nickname: String
    var memo: String
    
    var photoURL: URL
    var wakeUpAt: Date
}

//extension User {
//    fromApollo()
//}
