//
//  AlertableTests.swift
//  MorningBearUITests
//
//  Created by 이영빈 on 2022/12/06.
//  Copyright © 2022 com.dache. All rights reserved.
//

import XCTest
import UIKit

@testable import MorningBearUI

final class AlertableTests: XCTestCase {
    func test__alertifying_error() throws {
        let alertifiedError = MockError.seriousError.alertify
        XCTAssert((alertifiedError as Any) is Alertable)
    }
}

// MARK: Internal tools for testing
fileprivate struct MockStruct: Alertable {
    let alertComponent = AlertComponent(title: "Mock title")
}

fileprivate enum MockError: Error {
    case seriousError
}

