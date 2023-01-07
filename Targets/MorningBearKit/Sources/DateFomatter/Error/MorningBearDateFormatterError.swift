//
//  MorningBearDateFormatterError.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/05.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public enum MorningBearDateFormatterError: LocalizedError {
    case invalidString
    case emptyString
    
    public var errorDescription: String? {
        switch self {
        case .invalidString:
            return "입력 문자열의 포맷이 잘못되었습니다"
        case .emptyString:
            return "날짜 값이 존재하지 않습니다"
        }
    }
}
