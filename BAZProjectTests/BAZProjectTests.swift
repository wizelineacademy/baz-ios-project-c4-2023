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
    var instance = (UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TrendingViewController") as? TrendingViewController)
    
    override func setUp() {
        super.setUp()
        sut = instance
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
        let expectedResult: [ListMovieProtocol] = [Movie(id: 7, title: "Dragon Ball", posterPath: "")]
        // Then
        model.movies = expectedResult
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 10)
        // When
        XCTAssertEqual(rowCount, expectedResult.count)
    }
    
    func testTredingViewModelTitle_hasData() {
        // Given
        let expectedResult: [ListMovieProtocol] = [Movie(id: 7, title: "Dragon Ball", posterPath: "")]
        // Then
        model.movies = expectedResult
        // When
        XCTAssertNotNil(sut.trendingModel.getTitle(index: 0))
    }
    
    func testTredingViewModel_PosterPath_hasData() {
        // Given
        let expectedResult: [ListMovieProtocol] = [Movie(id: 4, title: "Dragon Ball Z", posterPath: "225252341tfrt433.jpg")]
        // Then
        model.movies = expectedResult
        // When
        XCTAssertNotNil(sut.trendingModel.getPosterPath(index: 0))
    }
    
    func testTredingViewModel_ImageLoader() {
        // Given
        var testImage = UIImage()
        // Then
        if let testURL = URL(string: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg") {
            model.getRemoteImage(from: testURL) { [weak self] urlImage in
                testImage = urlImage ?? UIImage()
                // When
                XCTAssertNotNil(testImage)
            }
        }
    }

}
