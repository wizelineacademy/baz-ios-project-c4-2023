//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by jehernandezg on 30/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {

    var sut: TrendingViewController!
    var model: MovieListProtocol!
    
    override func setUp() {
        super.setUp()
        sut = (UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TrendingViewController") as? TrendingViewController)
        model = TrendingViewModel()
        sut?.trendingModel = model
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        model = nil
    }
    
    func testTredingViewModel_hasData() {
        // Given
        let expectedResult: [ListMovieProtocol] = [Movie(id: 7, title: "Dragon Ball", poster_path: "")]
        // Then
        model.movies = expectedResult
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 10)
        // When
        XCTAssertEqual(rowCount, expectedResult.count)
    }
    
    func testTredingViewModelTitle_hasData() {
        // Given
        let expectedResult: [ListMovieProtocol] = [Movie(id: 7, title: "Dragon Ball", poster_path: "")]
        // Then
        model.movies = expectedResult
        // When
        XCTAssertNotNil(sut.trendingModel.getTitle(index: 0))
    }
    
    func testTredingViewModel_PosterPath_hasData() {
        // Given
        let expectedResult: [ListMovieProtocol] = [Movie(id: 4, title: "Dragon Ball Z", poster_path: "225252341tfrt433.jpg")]
        // Then
        model.movies = expectedResult
        // When
        XCTAssertNotNil(sut.trendingModel.getPosterPath(index: 0))
    }

}
