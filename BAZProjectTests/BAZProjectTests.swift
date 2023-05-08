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
    
    var detailInteractor: DetailInteractor?
    var detailPresenter: MockDetailPresenter?
    
    override func setUp() {
        super.setUp()
        homeInteractor = HomeInteractor()
        homePresenter = MockHomePresenter()
        homeInteractor?.presenter = homePresenter
        
        searchInteractor = SearchInteractor()
        searchPresenter = MockSearchPresenter()
        searchInteractor?.presenter = searchPresenter
        
        detailInteractor = DetailInteractor()
        detailPresenter = MockDetailPresenter()
        detailInteractor?.presenter = detailPresenter
    }

    override func tearDown() {
        super.tearDown()
        homeInteractor = nil
        homePresenter = nil
        
        searchInteractor = nil
        searchPresenter = nil
    }
    
    // MARK: - HomeModule
    func testWhen_HomeDataMovies_IsNotNull() {
        // Given
        let resultExpected = 20
        let expectation = XCTestExpectation(description: "getDataMovies1")
        // When
        homeInteractor?.getDataMovies(endPoint: .trending, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
        // Then
        XCTAssertEqual(homeInteractor?.movies?.count, resultExpected)
        XCTAssertNotNil(homeInteractor?.movies?.count)
    }
    
    func testWhen_HomeDataMovies_IsNull() {
        // Given
        let expectation = XCTestExpectation(description: "getDataMovies2")
        // When
        homeInteractor?.getDataMovies(endPoint: .invalid, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 9.0)
        // Then
        XCTAssertEqual(homeInteractor?.movies?.count, 0)
    }
    
    func testWhen_HomeGetMovieImage_IsNotNull() {
        // Given
        let movies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Avatar", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]
        homeInteractor?.movies = movies
        let expectation = XCTestExpectation(description: "Wait for getMovieImage completion")
        var testImage = UIImage()
        // Then
        homeInteractor?.getMovieImage(imagePath: movies[0].posterPath ?? "", completion: { movieImage in
            testImage = movieImage ?? UIImage()
            // When
            XCTAssertNotNil(testImage)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 9.0)
    }
    
    func testWhen_Home_SaveFavorite_IsNotNull() {
        // Given
        let movies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Avatar", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]
        let expectation = XCTestExpectation(description: "saveFavorite home")
        // When
        homeInteractor?.movies = movies
        homeInteractor?.saveFavorite(index: 0, onSaved: {
            self.homeInteractor?.getDataMovies(endPoint: .trending, completion: {
                expectation.fulfill()
            })
        })
        wait(for: [expectation], timeout: 10.0)
        // Then
        XCTAssertNotNil(homeInteractor?.getFavorites()?.count)
    }
    
    func testWhen_Home_DeleteFavorite_IsNotNull() {
        // Given
        let movies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Avatar", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]
        let expectation = XCTestExpectation(description: "saveFavorite home")
        // When
        homeInteractor?.movies = movies
        homeInteractor?.deleteFavorite(index: 0, onSaved: {
            self.homeInteractor?.getDataMovies(endPoint: .trending, completion: {
                expectation.fulfill()
            })
        })
        wait(for: [expectation], timeout: 10.0)
        // Then
        XCTAssertNotNil(homeInteractor?.getFavorites()?.count)
    }
    
    // MARK: - SearchModule
    func testWhen_Search_DataMovies_IsNotNull() {
        // Given
        let resultExpected = 20
        let expectation = XCTestExpectation(description: "getDataMovies3")
        // When
        searchInteractor?.getMovieSearch(endPoint: .trending, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
        // Then
        XCTAssertEqual(searchInteractor?.movies?.count, resultExpected)
        XCTAssertNotNil(searchInteractor?.movies?.count)
    }
    
    func testWhen_SearchDataMovies_IsNull() {
        // Given
        let expectation = XCTestExpectation(description: "getDataMovies4")
        // When
        searchInteractor?.getMovieSearch(endPoint: .invalid, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 9.0)
        // Then
        XCTAssertEqual(searchInteractor?.movies?.count, 0)
    }
    
    func testWhen_SearchGetMovieImage_IsNotNull() {
        // Given
        let movies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Avatar", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]
        searchInteractor?.movies = movies
        let expectation = XCTestExpectation(description: "Wait for getMovieImage completion")
        var testImage = UIImage()
        // Then
        searchInteractor?.getMovieImage(imagePath: movies[0].posterPath ?? "", completion: { movieImage in
            testImage = movieImage ?? UIImage()
            // When
            XCTAssertNotNil(testImage)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
    
    // MARK: - DetailModule
    func testWhen_Detail_DataMovies_IsNotNull() {
        // Given
        let resultExpected = 20
        let expectation = XCTestExpectation(description: "getDataMovies5")
        // When
        detailInteractor?.getMovies(endPoint: .trending, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
        // Then
        XCTAssertEqual(detailInteractor?.movies?.count, resultExpected)
        XCTAssertNotNil(detailInteractor?.movies?.count)
    }
    
    func testWhen_DetailDataMovies_IsNull() {
        // Given
        let expectation = XCTestExpectation(description: "getDataMovies6")
        // When
        detailInteractor?.getMovies(endPoint: .invalid, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 9.0)
        // Then
        XCTAssertEqual(detailInteractor?.movies?.count, 0)
    }
    
    func testWhen_DetailGetMovieImage_IsNotNull() {
        // Given
        let movies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Avatar", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]
        detailInteractor?.movies = movies
        let expectation = XCTestExpectation(description: "Wait for getMovieImage completion")
        var testImage = UIImage()
        // Then
        detailInteractor?.getMovieImage(imagePath: movies[0].posterPath ?? "", completion: { movieImage in
            testImage = movieImage ?? UIImage()
            // When
            XCTAssertNotNil(testImage)
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testWhen_Detail_Movie_IsNotNull() {
        // Given
        let movies: [ListMovieProtocol] = [MovieResult(id: 7, title: "Avatar", posterPath: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg")]
        // When
        detailInteractor?.getDetailMovie(detailMoviePI: movies[0])
        // Then
        XCTAssertNotNil(detailInteractor?.movies?.count)
    }
    
    func testWhen_Detail_Recomendations_IsNotNull() {
        // Given
        let resultExpected = 20
        let expectation = XCTestExpectation(description: "getRecomendations null")
        // When
        detailInteractor?.getRecomendations(endPoint: .trending, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 10.0)
        // Then
        XCTAssertEqual(detailInteractor?.recomendations?.count, resultExpected)
        XCTAssertNotNil(detailInteractor?.recomendations?.count)
    }
    
    func testWhen_Detail_Recomendations_IsNull() {
        // Given
        let expectation = XCTestExpectation(description: "getRecomendations not null")
        // When
        detailInteractor?.getRecomendations(endPoint: .invalid, completion: {
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 9.0)
        // Then
        XCTAssertEqual(detailInteractor?.movies?.count, 0)
    }

}
