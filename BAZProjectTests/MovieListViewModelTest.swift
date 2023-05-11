//
//  MovieListViewModelTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 30/03/23.
//

import XCTest
@testable import BAZProject

/// MovieListViewModelTest is a test class for the MovieListViewModel class. It tests various methods of the MovieListViewModel class that deal with fetching and displaying movie lists.
final class MovieListViewModelTest: XCTestCase {
    
    // MARK: - Properties

    /// The subject under test.
    private var sut: MovieListViewModel!
    
    // MARK: - Set up and tear down
    
    /// Sets up the test case by initializing the subject under test and setting its movies property to the decoded results from the trending movies fake JSON data.
    override func setUp() {
        super.setUp()

        // Set up the initial state of the subject under test.
        sut = MovieListViewModel(.trending)
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().trending)
        sut.setMovies(moveListFake?.results ?? [])
    }
    
    /// Tears down the test case by setting the subject under test to nil.
    override func tearDown() {
        // Clean up the state of the subject under test.
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test methods
    
    /// Tests the numberOfRowsInSection(_:) method of the subject under test by checking if the number of rows in the first section is equal to the expected number of trending movies.
    func testMovieList_whenReadFromMock_checkNumberOfTreandingMovies() {
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    /// Tests the movieAtIndex(_:) method of the subject under test by checking if the movie at the specified index is not nil.
    func testMovieList_whenSpecifyValidIndex_isNotNil() {
        let result = sut.movieAtIndex(0)

        XCTAssertNotNil(result)
    }
    
    /// Tests the movieAtIndex(_:) method of the subject under test by checking if the movie at the specified index is nil when the index is out of bounds.
    func testMovieList_whenSpecifyInvalidIndex_isNil() {
        let result = sut.movieAtIndex(100)

        XCTAssertNil(result)
    }
    
    /// Tests the numberOfRowsInSection(_:) method of the subject under test by checking if the number of rows in the first section is equal to the expected number of now playing movies.
    func testMoveList_whenReadFromMock_checkNumberOfNowPlayingMovies() {
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().now_playing)
        sut.setMovies(moveListFake?.results ?? [])
        
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    /// Tests the numberOfRowsInSection(_:) method of the subject under test by checking if the number of rows in the first section is equal to the expected number of popular movies.
    func testMoveList_whenReadFromMock_checkNumberOfPopularMovies() {
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().popular)
        sut.setMovies(moveListFake?.results ?? [])
        
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    /// Tests the numberOfRowsInSection(_:) method of the subject under test by checking if the number of rows in the first section is equal to the expected number of top rated movies.
    func testMoveList_whenReadFromMock_checkNumberOfTopRatedMovies() {
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().now_playing)
        sut.setMovies(moveListFake?.results ?? [])
        
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    /// Tests the numberOfRowsInSection() method of the MovieListViewModel class with a mock now playing movie list.
    /// It checks if the number of movies in the table view matches the expected number of movies.
    func testMoveList_whenReadFromMock_checkNumberOfUpcomingMovies() {
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().now_playing)
        sut.setMovies(moveListFake?.results ?? [])
        
        let resultExpected = 20
        let result = sut.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    /// Tests the applyMovieFilter() method of the MovieListViewModel class with a now playing movie filter.
    /// It checks if the number of movies in the table view matches the expected number of movies after applying the filter.
    func testMoveList_whenReadFromAPI_checkNumberOfNowPlayingMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados del filtro Now Playing")
        
        sut.applyMovieFilter(.nowPlaying) { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
    
    /// Tests the applyMovieFilter() method of the MovieListViewModel class with a popular movie filter.
    /// It checks if the number of movies in the table view matches the expected number of movies after applying the filter.
    func testMoveList_whenReadFromAPI_checkNumberOfPopularMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados del filtro Popular")
        
        sut.applyMovieFilter(.popular) { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
    
    /// Tests the applyMovieFilter() method of the MovieListViewModel class with a top rated movie filter.
    /// It checks if the number of movies in the table view matches the expected number of movies after applying the filter.
    func testMoveList_whenReadFromAPI_checkNumberOfTopRatedMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados del filtro Top Rated")
        
        sut.applyMovieFilter(.topRated) { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
    
    /// Tests the `applyMovieFilter(_:completion:)` method of the `MovieListViewModel` class for the `.upcoming` filter, and checks the number of movies in the filtered list.
    func testMoveList_whenReadFromAPI_checkNumberOfUpcomingMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados del filtro Upcoming")
        
        sut.applyMovieFilter(.upcoming) { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5)
    }
    
    /// Tests the `applyMovieFilter(_:completion:)` method of the `MovieListViewModel` class for the `.trending` filter, and checks the number of movies in the filtered list.
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
