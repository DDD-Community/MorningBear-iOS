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
    let timeFormatter = MorningBearDateFormatter.timeFormatter
    
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
            throw DataError.invalidData
        }

        let comment = commentText
        
        return MorningRegistrationInfo(image: image, startTime: startTimeDate, endTime: endTimeDate, comment: comment)
    }
}

extension RegisterMorningViewModel {
    enum DataError: LocalizedError {
        case emptyData
        case invalidData
        
        var errorDescription: String? {
            switch self {
            case .emptyData:
                return "데이터 처리 중 오류가 발생했습니다. 다시 시도해주세요."
            case .invalidData:
                return "데이터가 올바르지 않습니다. 다시 시도해주세요."
            }
        }
    }
}
