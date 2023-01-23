//
//  DataEditorError.swift
//  MorningBearDataEditor
//
//  Created by Young Bin on 2023/01/23.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

enum DataEditorError: LocalizedError {
    case cannotGetResponseFromServer
    case emptyResponse
    case invalidBadgeValues
    case invalidPhotoLink
    
    var errorDescription: String? {
        switch self {
        case .cannotGetResponseFromServer:
            return "서버에서 응답을 수신할 수 없습니다"
        case .emptyResponse:
            return "잘못된 응답"
        case .invalidBadgeValues:
            return "잘못된 배지 정보"
        case .invalidPhotoLink:
            return "잘못된 사진 정보"
        }
    }
}
