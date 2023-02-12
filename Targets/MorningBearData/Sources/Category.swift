//
//  Category.swift
//  MorningBearData
//
//  Created by Young Bin on 2023/02/01.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

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

public extension Category {
    static func fromId(_ id: String) -> Self? {
        guard id.count == 2 else {
            return nil
        }
        
        guard let idNumber = Int(id.suffix(1)) else {
            return nil
        }
        
        return Category(rawValue: idNumber - 1)
    }
}

extension Category: Hashable {
    public static func == (lhs: Category, rhs: Category) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}
