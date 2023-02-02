//
//  RegisterMorningViewModel.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/05.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

import RxSwift
import RxRelay

import MorningBearDataEditor
import MorningBearKit

class RegisterMorningViewModel<Editor: MyMorningDataEditing> {
    private let isNetworkingRelay = BehaviorRelay<Bool>(value: false)
    var isNetworking: Observable<Bool> {
        isNetworkingRelay.asObservable()
    }
    
    private let myMorningDataEditor: Editor

    let currentDate = Date()
    let categories: [String] = Category.allCases.map({ $0.description })

    /// 밖에서 보여줄 때 쓰는 시간 포매터
    let timeFormatter = MorningBearDateFormatter.timeFormatter
    
    /// 서버에 요청하는 형식인 HHMM으로 파싱하는 포매터
    private let dayFormatter = MorningBearDateFormatter.dayFormatter
    
    init(_ myMorningDataEditor: Editor = MyMorningDataEditor()) {
        self.myMorningDataEditor = myMorningDataEditor
    }
}

// MARK: - Public tools
extension RegisterMorningViewModel {
    func registerMorningInformation(_ image: UIImage,
                                    _ category: Int,
                                    _ startText: String,
                                    _ endText: String,
                                    _ commentText: String) -> Single<Void> {
        let formatter = self.timeFormatter
        
        // 텍스트 -> Date로 포맷
        guard let startTimeDate = formatter.date(from: startText),
              let endTimeDate = formatter.date(from: endText)
        else {
            return .error(MorningBearDateFormatterError.invalidString)
        }
        
        // 날짜 파싱 잘 되는지 확인
        guard let fullStartDate = startTimeDate.changeYearMonthDayValue(to: currentDate, is24Hour: false),
              let fullEndDate = endTimeDate.changeYearMonthDayValue(to: currentDate, is24Hour: false)
        else {
            return .error(RegisterMorningViewError.invalidDate(message: "형식이 올바르지 않습니다."))
        }
        
        // 시간 멀쩡한지 체크(시작 시간이 끝나는 시간보다 빠르게)
        guard fullStartDate < fullEndDate else {
            return .error(RegisterMorningViewError.invalidDate(message: "기록에 오류가 있습니다."))
        }

        // 코멘트 넣고
        let comment = commentText
        
        // 카테고리 넣고
        guard let intParsedCategory = Category(rawValue: category) else {
            return .error(RegisterMorningViewError.emptyCategory)
        }
        
        // 요청 객체 생성z
        let info = MorningRegistrationInfo(image: image, category: intParsedCategory,
                                           startTime: fullStartDate, endTime: fullEndDate,
                                           comment: comment)
        
        // 로딩 돌리고
        isNetworkingRelay.accept(true)
        
        // 요청
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
        return myMorningDataEditor.request(info: info)
            .do(onSuccess: { [weak self] (photoLink: String, updateBadges: [Badge]) in
                guard let self else { return }
                
                self.handleResponse(photoLink, updateBadges) // 성공하면 다음 처리 과정
            }, onError: { error in
                MorningBearLogger.track(error) // 실패하면 로그 찍고
                
                throw error // 뷰로 에러 던짐
            }, onDispose: { [weak self] in
                guard let self else { return }
                
                self.isNetworkingRelay.accept(false) // 해제되면 로딩 끝~
            })
            .map { _ in }
    }
    
    func handleResponse(_ photoLink: String, _ updatedBadges: [Badge]) {
        // 두 썸띵
    }
}

// MARK: - Error
enum RegisterMorningViewError: LocalizedError {
    case emptyData
    case emptyCategory
    case invalidDate(message: String)
    
    var errorDescription: String? {
        switch self {
        case .emptyData:
            return "데이터 처리 중 오류가 발생했습니다"
        case .emptyCategory:
            return "카테고리 정보가 선택되지 않았습니다"
        case .invalidDate(let message):
            return "\(message)"
        }
    }
}

