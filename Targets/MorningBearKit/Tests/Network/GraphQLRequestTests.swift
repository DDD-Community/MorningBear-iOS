//
//  GraphQLRequestTests.swift
//  MorningBearTests
//
//  Created by 이영빈 on 2022/11/29.
//  Copyright © 2022 com.dache. All rights reserved.
//

import XCTest

import Apollo
import StarWarsAPI

final class GraphQLRequestTests: XCTestCase {
    class Network {
      static let shared = Network()

      private(set) lazy var apollo = ApolloClient(url: URL(string: "https://swapi-graphql.netlify.app/.netlify/functions/index")!)
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        let expectation = XCTestExpectation(description: "graphQL")
        Network.shared.apollo.fetch(query: Query()) { result in
            switch result {
            case .success(let data):
                print(data)
            case .failure(let error):
                print(error)
            }
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
