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

        sut = MovieListViewModel(.trending)
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().trending)
        sut.setMovies(moveListFake?.results ?? [])
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testMovieList_whenReadFromMock_checkNumberOfTreandingMovies() {
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
    
    func testMoveList_whenReadFromMock_checkNumberOfNowPlayingMovies() {
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().now_playing)
        sut.setMovies(moveListFake?.results ?? [])
        
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    func testMoveList_whenReadFromMock_checkNumberOfPopularMovies() {
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().popular)
        sut.setMovies(moveListFake?.results ?? [])
        
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    func testMoveList_whenReadFromMock_checkNumberOfTopRatedMovies() {
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().now_playing)
        sut.setMovies(moveListFake?.results ?? [])
        
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    func testMoveList_whenReadFromMock_checkNumberOfUpcomingMovies() {
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().now_playing)
        sut.setMovies(moveListFake?.results ?? [])
        
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    func testMoveList_whenReadFromAPI_checkNumberOfNowPlayingMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados del filtro Now Playing")
        
        sut.applyMovieFilter(.nowPlaying) { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)

    }
    
    func testMoveList_whenReadFromAPI_checkNumberOfPopularMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados del filtro Popular")
        
        sut.applyMovieFilter(.popular) { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)

    }
    
    func testMoveList_whenReadFromAPI_checkNumberOfTopRatedMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados del filtro Top Rated")
        
        sut.applyMovieFilter(.topRated) { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)

    }
    
    func testMoveList_whenReadFromAPI_checkNumberOfUpcomingMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados del filtro Upcoming")
        
        sut.applyMovieFilter(.upcoming) { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)

    }
    
    func testMoveList_whenReadFromAPI_checkNumberOfTrendingMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados del filtro Treanding")
        
        sut.applyMovieFilter(.trending) { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)

    }

}
