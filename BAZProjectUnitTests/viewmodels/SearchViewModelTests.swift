//
//  SearchViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import XCTest
@testable import BAZProject

final class SearchViewModelTests: XCTestCase {

    var sut: SearchViewModel!
    var fakeRepository: SearchRepository!

    override func setUp() {
        super.setUp()
        fakeRepository = SearchFakes()
        sut = SearchViewModel(fakeRepository)
    }

    override func tearDown() {
        sut = nil
        fakeRepository = nil
        super.tearDown()
    }

    func testFetchSearchCallsSearchMoviesAndSearchKeyword() {
        let query = "Inception"
        sut.fetchSearch(query)

        let expectation = XCTestExpectation(description: "Completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.fakeRepository is SearchFakes)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testFetchSearchSetsSectionTitles() {
        let query = "Inception"

        sut.fetchSearch(query)

        let expectation = XCTestExpectation(description: "Completion")
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertTrue(self.fakeRepository is SearchFakes)
            XCTAssertEqual(self.sut.sectionTitles, ["Peliculas", "Otras sugerencias"])
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 3.0)
    }

    func testSearchResults() {
        let mockDelegate = MockSearchDelegate()
        mockDelegate.searchResults()
        XCTAssertTrue(mockDelegate.searchResultsCalled)
    }
}
