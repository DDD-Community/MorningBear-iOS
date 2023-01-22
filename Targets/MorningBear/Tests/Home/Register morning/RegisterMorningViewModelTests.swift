//
//  RegisterMorningViewModelTests.swift
//  MorningBearTests
//
//  Created by Young Bin on 2023/01/07.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest

import RxBlocking

@testable import MorningBear
@testable import MorningBearStorage
@testable import MorningBearDataEditor

final class RegisterMorningViewModelTests: XCTestCase {
    private var mockDataEditor: MyMorningDataEditing.Mock!
    private var viewModel: RegisterMorningViewModel<MyMorningDataEditing.Mock>!
    
    override func setUpWithError() throws {
        mockDataEditor = MyMorningDataEditor.Mock()
        
        mockDataEditor.requestMock.stub = { input in
            return .just((
                photoLink: self.expectedURL.absoluteString,
                updateBadges: [self.badge]
            ))
        }
        
        viewModel = RegisterMorningViewModel(mockDataEditor)
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
        
        let result = viewModel.registerMorningInformation(image, category, startText, endText, comment)
            .toBlocking()
            .materialize()
        
        switch result {
        case .failed:
            XCTFail("에러가 발생해서는 안 됨")
        default:
            break
        }
    }
    
    func test__convertTextFieldContentToInformation_fail() throws {
        // early end time
        let image = UIImage()
        let category = "정신"
        var startText = "오후 9시 30분"
        var endText = "오전 8시 30분"
        let comment = "fake comments"
        
        var result = viewModel.registerMorningInformation(image, category, startText, endText, comment)
            .toBlocking()
            .materialize()
        
        switch result {
        case .failed:
            break
        default:
            XCTFail("에러가 발생해야 함")
        }
            
        // false date string
        startText = "오후 9시 "
        endText = "오후 8시 90분"
        
        result = viewModel.registerMorningInformation(image, category, startText, endText, comment)
            .toBlocking()
            .materialize()
        
        switch result {
        case .failed:
            break
        default:
            XCTFail("에러가 발생해야 함")
        }
    }
}

extension RegisterMorningViewModelTests {
    var expectedURL: URL {
        URL(string: "www.naver.com")!
    }
    
    var badge: Badge {
        Badge(image: UIImage(systemName: "person")!, title: "title", desc: "desc")
    }
}
