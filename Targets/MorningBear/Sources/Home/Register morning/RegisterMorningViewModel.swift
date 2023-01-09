//
//  RegisterMorningViewModel.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/05.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import MorningBearKit

class RegisterMorningViewModel {
    let currentDate = Date()
    let categories: [String] = ["운동", "공부", "생활", "정서", "취미"]
    
    private let timeFormatter = MorningBearDateFormatter.timeFormatter
    private let shorttimeFormatter = MorningBearDateFormatter.shortimeFormatter
    private let dayFormatter = MorningBearDateFormatter.dayFormatter
}

// MARK: - Public tools
extension RegisterMorningViewModel {
    func registerMorningInformation(info: MorningRegistrationInfo) {
        print(info)
    }
    
    func convertViewContentToInformation(_ image: UIImage,
                                         _ startText: String,
                                         _ endText: String,
                                         _ commentText: String) throws -> MorningRegistrationInfo  {
        let formatter = self.timeFormatter
        
        guard let startTimeDate = formatter.date(from: startText),
              let endTimeDate = formatter.date(from: endText)
        else {
            throw MorningBearDateFormatterError.invalidString
        }
        
        guard startTimeDate < endTimeDate else {
            throw DataError.invalidDate
        }

        let comment = commentText
        
        return MorningRegistrationInfo(image: image, startTime: startTimeDate, endTime: endTimeDate, comment: comment)
    }
    
    var currentTimeString: String {
        return timeFormatter.string(from: currentDate)
    }
    
    var currdntDayString: String {
        return dayFormatter.string(from: currentDate)
    }
}

// MARK: - Error
extension RegisterMorningViewModel {
    // FIXME: 전역 에러로 바꾸는 것도 괜찮을 듯
    enum DataError: LocalizedError {
        case emptyData
        case emptyCategory
        case invalidDate
        
        var errorDescription: String? {
            switch self {
            case .emptyData:
                return "데이터 처리 중 오류가 발생했습니다"
            case .emptyCategory:
                return "카테고리 정보가 선택되지 않았습니다"
            case .invalidDate:
                return "날짜 데이터가 바르지 않습니다"
            }
        }
    }
}
