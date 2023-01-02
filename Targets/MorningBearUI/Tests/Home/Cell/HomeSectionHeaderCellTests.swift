//
//  HomeSectionHeaderCellTests.swift
//  MorningBearUITests
//
//  Created by 이영빈 on 2022/12/31.
//  Copyright © 2022 com.dache. All rights reserved.
//

import XCTest

@testable import MorningBearUI

final class HomeSectionHeaderCellTests: XCTestCase {
    private var header: HomeSectionHeaderCell! = nil

    override func setUpWithError() throws {
        let bundle = Bundle(for: HomeSectionHeaderCell.self)
        guard let cell = bundle.loadNibNamed("HomeSectionHeaderCell", owner: nil)?.first as? HomeSectionHeaderCell else {
            return XCTFail("HomeSectionHeaderCell nib did not contain a UIView")
        }
        
        header = cell
    }
    
    override func tearDownWithError() throws {
        header = nil
    }
    
    func test__disable_flag_work_properly() {
        // 초기화 시 가려져있어야 함
        XCTAssertTrue(header.moreButton.isHidden)
        
        // 버튼이 가려져있으면 비활성화 플래그도 `true`여야 한다
        XCTAssertEqual(header.moreButton.isHidden == true, header.isButtonDisabled == true)
    }
    
    func test__prepare_only_title() {
        // 타이틀 외에 버튼에 관한 정보를 입력하지 않으면 버튼이 비활성화 되는 것이 기본 로직임
        let titleText = "title_text"
        
        XCTAssertNotEqual(header.titleLabel.text, titleText)
        XCTAssertTrue(header.isButtonDisabled)
        
        header.prepare(title: titleText)
        
        XCTAssertEqual(header.titleLabel.text, titleText)
        XCTAssertTrue(header.isButtonDisabled) // 버튼이 활성화되지 않았는지 파악해야 함
    }

    func test__prepare() throws {
        let titleText = "title_text"
        let buttonText = "button_text"
        let buttonAction: () -> Void = {
            print("some")
        }
        
        XCTAssertNotEqual(header.titleLabel.text, titleText)
        XCTAssertNotEqual(header.moreButton.title(for: .normal), buttonText)
        XCTAssertTrue(header.isButtonDisabled)
        
        header.prepare(title: titleText, buttonText: buttonText, buttonAction: buttonAction)
        
        XCTAssertEqual(header.titleLabel.text, titleText)
        XCTAssertEqual(header.moreButton.title(for: .normal), buttonText)
        XCTAssertFalse(header.isButtonDisabled) // 버튼이 활성화 되었는지 확인해야 함
    }
}
