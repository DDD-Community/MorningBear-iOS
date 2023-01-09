//
//  Date + Extension.swift
//  MorningBearKit
//
//  Created by Young Bin on 2023/01/09.
//  Copyright © 2023 com.dache. All rights reserved.
//

import Foundation

public extension Date {
    /// Change year, month, day value
    func changeYearMonthDayValue(to currentDate: Date, is24Hour: Bool) -> Date? {
        let calendar = Calendar.current
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: currentDate)
        
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let second = calendar.component(.second, from: self)
        
        components.hour = is24Hour ? hour : hour + 12
        components.minute = minute
        components.second = second
        
        return calendar.date(from: components)
    }
}
