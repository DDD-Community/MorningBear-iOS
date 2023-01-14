//
//  MorningBearDateFormatter.swift
//  MorningBearKit
//
//  Created by 이영빈 on 2023/01/05.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public struct MorningBearDateFormatter {
    public static var `default`: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.mm.dd.hh.mm.ss"
        
        return formatter
    }
    
    /// ex. "오전 3시 30분"
    public static var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "a h시 m분"
        formatter.locale = Locale(identifier: "ko")
        
        return formatter
    }
    
    /// ex. "오전 3:30"
    public static var shortimeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "a hh:mm"
        formatter.locale = Locale(identifier: "ko")

        return formatter
    }
    
    public static var dayFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 M월 d일"
        
        
        return formatter
    }
}
