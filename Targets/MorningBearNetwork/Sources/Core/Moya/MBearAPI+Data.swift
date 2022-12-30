//
//  MBear+Data.swift
//  MorningBearKit
//
//  Created by 이영빈 on 2022/11/28.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

extension MBearAPI {
    var getSampleData: Data {
        switch self {
        case .login:
            return "{\"name\": \"test Name\"}".data(using: String.Encoding.utf8)!
        case .signOut:
            return Data()
        case .example(token: let token):
            return Data()
        }
    }
}
