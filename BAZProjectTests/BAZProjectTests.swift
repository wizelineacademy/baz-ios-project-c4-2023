//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by jehernandezg on 30/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {

    var homeInteractor: HomeInteractor?
    var homePresenter: MockHomePresenter?
    
    var searchInteractor: SearchInteractor?
    var searchPresenter: MockSearchPresenter?
    
    override func setUp() {
        super.setUp()
        homeInteractor = HomeInteractor()
        homePresenter = MockHomePresenter()
        homeInteractor?.presenter = homePresenter
        
        searchInteractor = SearchInteractor()
        searchPresenter = MockSearchPresenter()
        searchInteractor?.presenter = searchPresenter
    }

    override func tearDown() {
        super.tearDown()
        homeInteractor = nil
        homePresenter = nil
        
        searchInteractor = nil
        searchPresenter = nil
    }
    
    func testWhen_HomeDataMovies_IsNotNull() {
        // Given
        let resultExpected = 1
        // When
        homeInteractor?.getDataMovies()
        // Then
        XCTAssertEqual(homePresenter?.arrMovies.count, resultExpected)
    }
    
    func testWhen_HomeGetMovieImage_IsNotNull() {
        // Given
        let movies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Avatar", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]
        homeInteractor?.movies = movies
        let expectation = XCTestExpectation(description: "Wait for getMovieImage completion")
        var testImage = UIImage()
        // Then
        homeInteractor?.getMovieImage(index: 0, completion: { movieImage in
            testImage = movieImage ?? UIImage()
            // When
            XCTAssertNotNil(testImage)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testWhen_Search_DataMovies_IsNotNull() {
        // Given
        let resultExpected = 1
        // When
        searchInteractor?.getMovieSearch(movieName: "Halo")
        // Then
        XCTAssertEqual(searchPresenter?.arrSeaerchMovies.count, resultExpected)
    }
    
    func testWhen_SearchGetMovieImage_IsNotNull() {
        // Given
        let movies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Avatar", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]
        searchInteractor?.movies = movies
        let expectation = XCTestExpectation(description: "Wait for getMovieImage completion")
        var testImage = UIImage()
        // Then
        searchInteractor?.getMovieImage(index: 0, completion: { movieImage in
            testImage = movieImage ?? UIImage()
            // When
            XCTAssertNotNil(testImage)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
}
