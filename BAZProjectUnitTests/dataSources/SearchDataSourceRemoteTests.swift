//
//  SearchDataSourceRemoteTests.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import XCTest
@testable import BAZProject

final class SearchDataSourceRemoteTests: XCTestCase {
    
    var sut: SearchDataSourceRemote!

    override func setUp() {
        super.setUp()
        sut = SearchDataSourceRemote()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSearchMovies() {
        let expectation = XCTestExpectation(description: "Search movies")

        sut.searchMovies(query: "action") { movies in
            XCTAssertFalse(movies.isEmpty, "Movies should not be empty")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }

    func testSearchKeyword() {
        let expectation = XCTestExpectation(description: "Search keyword")

        sut.searchKeyword(query: "comedy") { keywords in
            XCTAssertFalse(keywords.isEmpty, "Keywords should not be empty")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 10.0)
    }
}
