//
//  MorningBearDateFormatter.swift
//  MorningBearKit
//
//  Created by 이영빈 on 2023/01/05.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public struct MorningBearDateFormatter {
    public static let `default` = DateFormatter()
    
    public static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h시 m분"
        
        return formatter
    }
    
    public static var shortimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"

        return formatter
    }
    
    public static var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        
        
        return formatter
    }
}
