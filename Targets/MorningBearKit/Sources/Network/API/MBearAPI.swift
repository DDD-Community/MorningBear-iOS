//
//  AuthorizationAPI.swift
//  Naenio
//
//  Created by 이영빈 on 2022/07/14.
//
/*
 API endpoint 케이스 정의
 */

import Foundation
import Moya

struct FakeData: Codable {
    let name: String
}

enum MBearAPI {
    case login(load: FakeData)
    case signOut
    case example(token: String)
}

extension MBearAPI: TargetType {
    var baseURL: URL {
        return URL(string: KeyValue.baseURL)!
    }

    var path: String {
        self.getPath
    }
    
    var method: Moya.Method {
        self.getMethod
    }
  
    var sampleData: Data {
        self.getSampleData
    }
    
    var task: Task {
        self.getTask
    }

    var headers: [String: String]? {
        switch self {
        default:
            return [
                MBearAPIHeaderKey.accept: MBearAPIHeaderValue.json,
                MBearAPIHeaderKey.contentType: MBearAPIHeaderValue.json,
                MBearAPIHeaderKey.authorization: MBearAPIHeaderValue.authoization
            ]
        }
    }
}
