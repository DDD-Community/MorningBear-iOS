//
//  HomeSectionFooterCellTests.swift
//  MorningBearUITests
//
//  Created by 이영빈 on 2022/12/31.
//  Copyright © 2022 com.dache. All rights reserved.
//

import XCTest

@testable import MorningBearUI

final class HomeSectionFooterCellTests: XCTestCase {
    private var footer: HomeSectionFooterCell! = nil

    override func setUpWithError() throws {
        let bundle = Bundle(for: HomeSectionFooterCell.self)
        guard let cell = bundle.loadNibNamed("HomeSectionFooterCell", owner: nil)?.first as? HomeSectionFooterCell else {
            return XCTFail("HomeSectionFooterCell nib did not contain a UIView")
        }
        
        footer = cell
    }
    
    override func tearDownWithError() throws {
        footer = nil
    }
    
    func test__prepare() throws {
        let buttonText = "button_text"
        let buttonAction: () -> Void = {
            print("some")
        }
        
        XCTAssertNotEqual(footer.button.title(for: .normal), buttonText)
        
        footer.prepare(buttonText: buttonText, buttonAction: buttonAction)
        
        XCTAssertEqual(footer.button.title(for: .normal), buttonText)
    }
}
