//
//  MyMorningDateEditorTests.swift
//  MorningBearDataEditorTests
//
//  Created by Young Bin on 2023/01/22.
//  Copyright © 2023 com.dache. All rights reserved.
//

import XCTest
import RxBlocking

@testable import MorningBearStorage
@testable import MorningBearDataEditor
@testable import MorningBearStorage


final class MyMorningDateEditorTests: XCTestCase {
    public typealias Firebase = FirebaseStorageService

    private var mockStorageManager: FirebaseStorageManagerMock!
    private var myMorningDataEditor: MyMorningDataEditor!

    override func setUpWithError() throws {
        mockStorageManager = FirebaseStorageManagerMock()
        myMorningDataEditor = MyMorningDataEditor(mockStorageManager)
    }

    override func tearDownWithError() throws {
        mockStorageManager = nil
        myMorningDataEditor = nil
    }

    func testRequestMutation() throws {
        mockStorageManager.stubSaveImage.stub = { image in
            XCTAssertEqual(image.accessibilityIdentifier, self.expectedImage.accessibilityIdentifier)
            
            return .just(self.expectedURL)
        }
        
        let info = MorningRegistrationInfo(
            image: expectedImage, category: .exercies, startTime: Date(), endTime: Date(), comment: ""
        )
        
        let result = myMorningDataEditor.request(info: info)
            .asObservable()
            .toBlocking()
            .materialize()
        
        switch result {
        case .completed(let elements):
            let result = try XCTUnwrap(elements.first)
            
            XCTAssertEqual(result.photoLink, expectedURL.absoluteString)
            
        case .failed(let elements, let error):
            XCTFail("Returned: \(elements). Error: " + error.localizedDescription)
        }
    }
}

extension MyMorningDateEditorTests {
    fileprivate var expectedURL: URL { URL(string: "www.nazver.com")! }
    fileprivate var expectedImage: UIImage { UIImage(systemName: "person")! }
}
