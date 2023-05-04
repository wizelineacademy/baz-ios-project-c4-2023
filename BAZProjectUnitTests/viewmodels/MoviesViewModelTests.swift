//
//  MoviesViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import XCTest
@testable import BAZProject

final class MoviesViewModelTests: XCTestCase {

    var sut: MoviesViewModel!
    var fakeRepository: MoviesRepository!

    override func setUp() {
        super.setUp()
        fakeRepository = MoviesFakes()
        sut = MoviesViewModel(fakeRepository)
    }
    
    override func tearDown() {
        sut = nil
        fakeRepository = nil
        super.tearDown()
    }
    
    func testFetchMoviesTrending() {
        var movies: [Movie]?

        sut.onMoviesUpdate = { [self] in
            movies = sut.movies
        }
        XCTAssertNotNil(sut.onMoviesUpdate)
        sut.fetchMovies(.trending)

        XCTAssertNotNil(movies)
        XCTAssertEqual(movies?.count, 2)
    }
    
    func testFetchMoviesNowPlaying() {
        var movies: [Movie]?

        sut.onMoviesUpdate = { [self] in
            movies = sut.movies
        }
        XCTAssertNotNil(sut.onMoviesUpdate)
        sut.fetchMovies(.nowPlaying)

        XCTAssertNotNil(movies)
        XCTAssertEqual(movies?.count, 3)
    }
    
    func testFetchMoviesPopular() {
        var movies: [Movie]?

        sut.onMoviesUpdate = { [self] in
            movies = sut.movies
        }
        XCTAssertNotNil(sut.onMoviesUpdate)
        sut.fetchMovies(.popular)

        XCTAssertNotNil(movies)
        XCTAssertEqual(movies?.count, 4)
    }
    
    func testFetchMoviesTopRated() {
        var movies: [Movie]?

        sut.onMoviesUpdate = { [self] in
            movies = sut.movies
        }
        XCTAssertNotNil(sut.onMoviesUpdate)
        sut.fetchMovies(.topRated)

        XCTAssertNotNil(movies)
        XCTAssertEqual(movies?.count, 5)
    }
    
    func testFetchMoviesUpcoming() {
        var movies: [Movie]?

        sut.onMoviesUpdate = { [self] in
            movies = sut.movies
        }
        XCTAssertNotNil(sut.onMoviesUpdate)
        sut.fetchMovies(.upcoming)

        XCTAssertNotNil(movies)
        XCTAssertEqual(movies?.count, 6)
    }

    func testFetchRelatedMoviesSimilar() {
        var movies: [Movie]?
        
        sut.onMoviesUpdate = { [self] in
            movies = sut.movies
        }
        XCTAssertNotNil(sut.onMoviesUpdate)
        sut.fetchRelatedMovies(.similar, 603)

        XCTAssertNotNil(movies)
        XCTAssertEqual(movies?.count, 7)
    }
    
    func testFetchRelatedMoviesRecommendations() {
        var movies: [Movie]?
        
        sut.onMoviesUpdate = { [self] in
            movies = sut.movies
        }
        XCTAssertNotNil(sut.onMoviesUpdate)
        sut.fetchRelatedMovies(.recommendations, 603)

        XCTAssertNotNil(movies)
        XCTAssertEqual(movies?.count, 8)
    }
}
