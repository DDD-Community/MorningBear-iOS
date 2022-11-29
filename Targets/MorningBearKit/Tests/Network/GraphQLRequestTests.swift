//
//  GraphQLRequestTests.swift
//  MorningBearTests
//
//  Created by 이영빈 on 2022/11/29.
//  Copyright © 2022 com.dache. All rights reserved.
//

import XCTest

import Apollo
import RxSwift
import StarWarsAPI

@testable import MorningBearKit

final class GraphQLRequestTests: XCTestCase {
    let bag = DisposeBag()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test__apollo_fetch() {
        let expectation = XCTestExpectation(description: "graphQL")

        Network.shared.apollo.fetch(query: Query()) { result in
            switch result {
            case .success(let data):
                print(data.data?.allFilms?.films as Any)
            case .failure(let error):
                print(error)
            }

            expectation.fulfill()
        }
    }
    
    func test__RxApollo_fetch() throws {
        let expectation = XCTestExpectation(description: "graphQL")
        
        Network.shared.apollo.rx.fetch(query: Query())
            .subscribe(
                onSuccess: { data in
                    print(data.data?.allFilms?.films as Any)
                    expectation.fulfill()
                }, onFailure: { error in
                    XCTFail("Test get failed: \(error)")
                })
            .disposed(by: bag)
        
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
