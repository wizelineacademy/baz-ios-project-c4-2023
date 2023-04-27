//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by Manuel S on 30/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {
    
    var sut: TrendingViewController!
    var model: MoviesListProtocol!
    
    override func setUp() {
        super.setUp()
        sut = (UIStoryboard(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "TrendingViewController") as! TrendingViewController)
        model = TrendingViewModel()
        sut?.trendingModel = model
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        model = nil
    }
    
    func testTredingViewModel_NotNil() {
        //Given
        let expectedResult: [ListMoviesProtocol] = [Movie(id: 1, title: "Titanic", poster_path: "")]
        //Then
        model.movies = Box(value: expectedResult)
        sut.getMovieArray()
        let rowCount = sut.tableView(sut.tableView, numberOfRowsInSection: 0)
        //When
        XCTAssertEqual(rowCount, expectedResult.count)
    }
}


