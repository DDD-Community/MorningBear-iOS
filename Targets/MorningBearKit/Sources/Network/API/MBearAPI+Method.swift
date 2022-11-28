//
//  NaenioAPI+Method.swift
//  Naenio
//
//  Created by 이영빈 on 2022/08/13.
//
import Moya
extension MBearAPI {
    var getMethod: Moya.Method {
        switch self {
        case .login:
            return .post
        case .signOut:
            return .get
        case .example(token: let token):
            return .put
        }
    }
}
