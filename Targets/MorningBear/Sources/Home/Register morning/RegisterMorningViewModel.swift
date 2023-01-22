//
//  RegisterMorningViewModel.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/05.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift

import MorningBearDataEditor
import MorningBearData
import MorningBearKit

class RegisterMorningViewModel<Editor: MyMorningDataEditing> {
    private let myMorningDataEditor: Editor

    let currentDate = Date()
    let categories: [String] = ["운동", "공부", "생활", "정서", "취미"]

    let timeFormatter = MorningBearDateFormatter.timeFormatter
    private let shorttimeFormatter = MorningBearDateFormatter.shortimeFormatter
    private let dayFormatter = MorningBearDateFormatter.dayFormatter
    
    init(_ myMorningDataEditor: Editor = MyMorningDataEditor()) {
        self.myMorningDataEditor = myMorningDataEditor
    }
}

// MARK: - Public tools
extension RegisterMorningViewModel {
    typealias RegistrationInfo = Editor.InputType
    typealias ReturnType = Editor.ReturnType
    
    func registerMorningInformation(_ image: UIImage,
                                    _ category: String,
                                    _ startText: String,
                                    _ endText: String,
                                    _ commentText: String) -> Single<Void> {
        let formatter = self.timeFormatter
        
        guard let startTimeDate = formatter.date(from: startText),
              let endTimeDate = formatter.date(from: endText)
        else {
            return .error(MorningBearDateFormatterError.invalidString)
        }
        
        guard let fullStartDate = startTimeDate.changeYearMonthDayValue(to: currentDate, is24Hour: false),
              let fullEndDate = endTimeDate.changeYearMonthDayValue(to: currentDate, is24Hour: false) else {
            return .error(DataError.invalidDate)
        }
        
        guard fullStartDate < fullEndDate else {
            return .error(DataError.invalidDate)
        }

        let comment = commentText
        
        let info = MorningRegistrationInfo(image: image, category: category,
                                           startTime: fullStartDate, endTime: fullEndDate,
                                           comment: comment)
        
        return handleRegisterRequest(info: info) //  map to void
    }
    
    var currentTimeString: String {
        return timeFormatter.string(from: currentDate)
    }
    
    var currdntDayString: String {
        return dayFormatter.string(from: currentDate)
    }
}

private extension RegisterMorningViewModel {
    func handleRegisterRequest(info: MorningRegistrationInfo) -> Single<Void> {
        return myMorningDataEditor.request(info)
            .do(onSuccess: { [weak self] (photoLink: String, updateBadges: [Badge]) in
                guard let self else { return }
                
                self.handleResponse(photoLink, updateBadges)
            }, onError: { error in
                throw error
            })
            .map { _ in }
    }
    
    func handleResponse(_ photoLink: String, _ updatedBadges: [Badge]) {
        
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
