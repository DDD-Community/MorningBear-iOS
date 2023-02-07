////
////  MyMorningDateEditorTests.swift
////  MorningBearDataEditorTests
////
////  Created by Young Bin on 2023/01/22.
////  Copyright © 2023 com.dache. All rights reserved.
////
//
//import XCTest
//import RxBlocking
//
//@testable import MorningBearStorage
//@testable import MorningBearDataEditor
//
//final class MyMorningDateEditorTests: XCTestCase {
//    private var mockStorageManager: (any RemoteStoraging)!
//    private var myMorningDataEditor: MyMorningDataEditor!
//
//    override func setUpWithError() throws {
//        mockStorageManager = RemoteStoraging.Mock(saveAction: {
//            .just(self.expectedURL)
//        }, loadAction: {
//            .just(self.expectedImage)
//        })
//        
//        myMorningDataEditor = MyMorningDataEditor(mockStorageManager)
//    }
//
//    override func tearDownWithError() throws {
//        mockStorageManager = nil
//        myMorningDataEditor = nil
//    }
//
//    func testExample() throws {
//        let info = MorningRegistrationInfo(image: expectedImage, category: "1", startTime: Date(), endTime: Date(), comment: "comment")
//        let result = myMorningDataEditor.request(info)
//            .asObservable()
//            .toBlocking()
//            .materialize()
//        
//        switch result {
//        case .completed(let elements):
//            let link = try XCTUnwrap(elements.first?.photoLink)
//            XCTAssertEqual(link, expectedURL.absoluteString)
//        case .failed(let elements, let error):
//            XCTFail("Returned: \(elements). Error: " + error.localizedDescription)
//        }
//    }
//}
//
//extension MyMorningDateEditorTests {
//    fileprivate var expectedURL: URL { URL(string: "www.naver.com")! }
//    fileprivate var expectedImage: UIImage { UIImage(systemName: "person")! }
//}
