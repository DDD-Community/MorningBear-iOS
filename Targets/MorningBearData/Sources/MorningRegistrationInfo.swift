//
//  MorningInformation.swift
//  MorningBear
//
//  Created by 이영빈 on 2023/01/05.
//  Copyright © 2023 com.dache. All rights reserved.
//

import UIKit

public struct MorningRegistrationInfo {
    public let image: UIImage
    public let category: String
    public let startTime: Date
    public let endTime: Date
    public let comment: String
    
    public init(image: UIImage, category: Category, startTime: Date, endTime: Date, comment: String) {
        self.image = image
        self.category = category.id
        self.startTime = startTime
        self.endTime = endTime
        self.comment = comment
    }
    
    public enum Category: Int, CaseIterable {
        case exercies
        case study
        case living
        case emotion
        case hobby
        
        public var description: String {
            switch self {
            case .exercies:
                return "운동"
            case .study:
                return "공부"
            case .living:
                return "생활"
            case .emotion:
                return "정서"
            case .hobby:
                return "취미"
            }
        }
        
        var id: String {
            switch self {
            case .exercies:
                return "C1"
            case .study:
                return "C2"
            case .living:
                return "C3"
            case .emotion:
                return "C4"
            case .hobby:
                return "C5"
            }
        }
    }
}
