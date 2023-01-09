//
//  RegisterMorningViewModelTests.swift
//  MorningBearTests
//
//  Created by Young Bin on 2023/01/07.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest

@testable import MorningBear

final class RegisterMorningViewModelTests: XCTestCase {
    private var viewModel: RegisterMorningViewModel!

    override func setUpWithError() throws {
        viewModel = RegisterMorningViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func test__convertTextFieldContentToInformation_success() throws {
        let image = UIImage()
        let category = "정신"
        let startText = "오전 8시 30분"
        let endText = "오후 9시 30분"
        let comment = "fake comments"
        
        XCTAssertNoThrow(try viewModel.convertViewContentToInformation(image, category, startText, endText, comment))
    }
    
    
    func test__convertTextFieldContentToInformation_fail() throws {
        // early end time
        let image = UIImage()
        let category = "정신"
        var startText = "오후 9시 30분"
        var endText = "오전 8시 30분"
        let comment = "fake comments"
        XCTAssertThrowsError(try viewModel.convertViewContentToInformation(image, category, startText, endText, comment))
        
        // false date string
        startText = "오후 9시 "
        endText = "오후 8시 90분"
        XCTAssertThrowsError(try viewModel.convertViewContentToInformation(image, category, startText, endText, comment))
    }
}
