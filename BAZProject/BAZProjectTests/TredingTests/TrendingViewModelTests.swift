//
//  TrendingViewModelTests.swift
//  BAZProjectTests
//
//  Created by Manuel S on 30/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingViewModelTests: XCTestCase {
    
    var sut: TrendingViewModel?
    var movieAPIMock: MovieApiMock?

    override func setUp() {
        super.setUp()
        
        movieAPIMock = MovieApiMock(service: ServiceAPI(session: SessionMock()))
        sut = TrendingViewModel(remote: movieAPIMock!)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTrendingModel_TableViewNotZerp() {
        //Given
        let movies = [Movie(id: 1, title: "Titanic", poster_path: "")]
        //When
        sut?.movies = Box(value: movies)
        let count = sut?.getMovieCount()
        //Then
        XCTAssertEqual(count, movies.count)
    }
    
    func testTrendingModel_TitleNotNil() {
        //Given
        let movies = [Movie(id: 1, title: "Titanic", poster_path: "")]
        //When
        sut?.movies = Box(value: movies)
        let title = sut?.getTitle(index: 0)
        //Then
        XCTAssertEqual("Titanic", title)
    }
    
    func testTrendingModel_getMovies() {
        //Given
        let movies = [Movie(id: 1, title: "Titanic", poster_path: "")]
        let expectation = XCTestExpectation()
        //When
        movieAPIMock?.movies = movies
        sut?.bindMovies { expectation.fulfill() }
        sut?.getmovies(category: .nowPlaying)
        wait(for: [expectation], timeout: 0.1)
        let count = sut?.getMovieCount()
        //Then
        XCTAssertEqual(count, movies.count)
    }
    
    func testTrendingModel_MovieDetailNotNil() {
        //Given
        let movies = [Movie(id: 1, title: "Titanic", poster_path: "")]
        //When
        sut?.movies = Box(value: movies)
        let movie = sut?.getAllInfoMoview(index: 0)
        //Then
        XCTAssertEqual("Titanic", movie?.title)
    }
}
