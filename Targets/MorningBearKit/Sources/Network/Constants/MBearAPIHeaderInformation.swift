//
//  HeaderInformation.swift
//  Naenio
//
//  Created by 이영빈 on 2022/07/14.
//

import Foundation

enum MBearAPIHeaderKey {
    static let contentType = "Content-Type"
    static let authorization = "Authorization"
    static let accept = "accept"
}

enum MBearAPIHeaderValue {
    static let json = "application/json"
    static var authoization: String { "Bearer \("access token")" } // FIXME:
}
