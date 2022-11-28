//
//  AuthorizationAPI+Path.swift
//  Naenio
//
//  Created by 이영빈 on 2022/11/28.
//

import Moya

extension MBearAPI {
    var getPath: String {
        switch self {
        case .login: return "/app/login"
        case .signOut: return "/app/signOut"
        case .example(let userToken): return "/app/comments/\(userToken)"
        }
    }
}
