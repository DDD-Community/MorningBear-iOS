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
import StarWarsAPITestMocks

import MorningBearAPI
import MorningBearAPITestMocks

import ApolloTestSupport

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

//        Network.shared.apollo.fetch(query: Query()) { result in
//            switch result {
//            case .success(let data):
//                print(data.data?.allFilms?.films as Any)
//            case .failure(let error):
//                print(error)
//            }
//
//            expectation.fulfill()
//        }
        
        Network.shared.apollo.fetch(query: FindLoginInfoQuery()) { result in
            switch result {
            case .success(let data):
                print(data.data?.findLoginInfo as Any)
            case .failure(let error):
                print("TEST: Error", error.localizedDescription)
            }

            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func test__RxApollo_fetch() throws {
        let expectation = XCTestExpectation(description: "graphQL")
        
        Network.shared.apolloTest.rx.fetch(query: Query())
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
    
    func test__Mocking() throws {
        let mock = Mock(allFilms:
                            Mock(films: [
                                Mock(title: "1"),
                                Mock(title: "2"),
                                Mock(title: nil),
                                nil
                            ]
                                )
        )
        
        guard
            let allFilms = Query.Data.from(mock).allFilms,
            let films = allFilms.films
        else {
            XCTFail("Model nil")
            return
        }
        
        let titles = films
            .compactMap { $0 }
            .compactMap { $0.title }
        
        XCTAssertEqual(titles.count, 2)
        XCTAssertTrue(titles.contains("1") && titles.contains("2"))
    }
}
