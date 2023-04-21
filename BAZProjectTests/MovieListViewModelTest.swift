//
//  MovieListViewModelTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 30/03/23.
//

import XCTest
@testable import BAZProject

final class MovieListViewModelTest: XCTestCase {

    private var sut: MovieListViewModel!
    
    override func setUp() {
        super.setUp()
        
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().trending)

        self.sut = MovieListViewModel(.trending)
        sut.setMovies(moveListFake?.results ?? [])
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testMovieList_whenReadFromMock_checkNumberOfMovies() {
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    func testMovieList_whenSpecifyValidIndex_isNotNil() {
        let result = sut.movieAtIndex(0)

        XCTAssertNotNil(result)
    }
    
    func testMovieList_whenSpecifyInvalidIndex_isNil() {
        let result = sut.movieAtIndex(100)

        XCTAssertNil(result)
    }

}
