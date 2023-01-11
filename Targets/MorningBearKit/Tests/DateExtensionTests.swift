//
//  DateExtensionTests.swift
//  MorningBearKitTests
//
//  Created by Young Bin on 2023/01/09.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest
@testable import MorningBearKit

final class DateExtensionTests: XCTestCase {
    private var formatter: DateFormatter!

    override func setUpWithError() throws {
        formatter = DateFormatter()
    }

    override func tearDownWithError() throws {
        formatter = nil
    }

    func test__addDayValue() throws {
        // 날짜 없는 포맷
        formatter.dateFormat = "hh:mm:ss"
        
        let sampleDate = sampleDate(year: 2023, month: 1, day: 1)
        let testDateString = formatter.string(from: sampleDate)
        
        guard let testDate = formatter.date(from: testDateString) else {
            XCTFail("이상한 날짜 형식")
            return
        }
        XCTAssertNotEqual(sampleDate, testDate)
        
        let changedDate = testDate.changeYearMonthDayValue(to: sampleDate, is24Hour: false)
        XCTAssertEqual(sampleDate, changedDate)
    }
}

private extension DateExtensionTests {
    func sampleDate(year: Int, month: Int, day: Int) -> Date {
        let gregorian = Calendar.current
        let nowDate = Date()
        var components = gregorian.dateComponents([.year, .month, .day, .hour, .minute, .second], from: nowDate)
        
        components.year = year
        components.month = month
        components.day = day
        
        return gregorian.date(from: components)!
    }
}
