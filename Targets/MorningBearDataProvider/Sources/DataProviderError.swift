//
//  DataProviderError.swift
//  MorningBearDataProvider
//
//  Created by Young Bin on 2023/01/23.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

enum DataProviderError: LocalizedError {
    case cannotGetResponseFromServer
    case emptyResponse
    case invalidPayloadData
    
    var errorDescription: String? {
        switch self {
        case .cannotGetResponseFromServer:
            return "서버에서 응답을 수신할 수 없습니다"
        case .emptyResponse:
            return "잘못된 응답"
        case .invalidPayloadData:
            return "잘못된 페이로드"
        }
    }
}
