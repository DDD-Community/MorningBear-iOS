//
//  AuthorizationAPI+Task.swift
//  Naenio
//
//  Created by 이영빈 on 2022/07/17.
//

import Moya

extension MBearAPI {
    var getTask: Task {
        switch self {
        case .signOut:
            return .requestPlain
        case .login:
            return .requestParameters(parameters: ["isFirst": true], encoding: JSONEncoding.default)
        case .example(let request):
            return .requestParameters(parameters: request.toDictionary(), encoding: URLEncoding.default)
        }
    }
}
