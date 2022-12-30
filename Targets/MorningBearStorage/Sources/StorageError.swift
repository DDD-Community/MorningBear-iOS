//
//  StorageError.swift
//  MorningBearKit
//
//  Created by Young Bin on 2022/12/04.
//  Copyright © 2022 com.dache. All rights reserved.
//

import Foundation

enum StorageError: LocalizedError {
    case invalidData
    case invalidImage
    case invalidPath
    case failToLoadImage
    case failToSaveImage
    case failToFetchData
    
    var errorDescription: String? {
        switch self {
        case .invalidData:
            return "데이터를 불러올 수 없습니다"
        case .invalidImage:
            return "이미지 처리 중 오류가 발생했습니다"
        case .invalidPath:
            return "경로가 잘못되었습니다"
        case .failToLoadImage:
            return "이미지 다운로드 중 오류가 발생했습니다"
        case .failToSaveImage:
            return "이미지 업로드 중 오류가 발생했습니다"
        case .failToFetchData:
            return "저장된 데이터를 불러올 수 없습니다"
        }
    }
}
