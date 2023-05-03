//
//  MoviesDataSourceRemoteTests.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import XCTest
@testable import BAZProject

final class MoviesDataSourceRemoteTests: XCTestCase {
    
    var sut: MoviesDataSourceRemote!

    override func setUp() {
        super.setUp()
        sut = MoviesDataSourceRemote()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetMoviesTrending() throws {
        let expectation = self.expectation(description: "Películas obtenidas con éxito")
        var movies: [Movie]?

        sut.getMovies(filter: .trending) { fetchedMovies in
            movies = fetchedMovies
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(movies, "La matriz de películas no debe ser nil")
        XCTAssertTrue(movies!.count > 0, "La matriz de películas no debe estar vacía")
    }
    
    func testGetMoviesNowPlaying() throws {
        let expectation = self.expectation(description: "Películas obtenidas con éxito")
        var movies: [Movie]?

        sut.getMovies(filter: .nowPlaying) { fetchedMovies in
            movies = fetchedMovies
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(movies, "La matriz de películas no debe ser nil")
        XCTAssertTrue(movies!.count > 0, "La matriz de películas no debe estar vacía")
    }
    
    func testGetMoviesPopular() throws {
        let expectation = self.expectation(description: "Películas obtenidas con éxito")
        var movies: [Movie]?

        sut.getMovies(filter: .popular) { fetchedMovies in
            movies = fetchedMovies
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(movies, "La matriz de películas no debe ser nil")
        XCTAssertTrue(movies!.count > 0, "La matriz de películas no debe estar vacía")
    }
    
    func testGetMoviesTopRated() throws {
        let expectation = self.expectation(description: "Películas obtenidas con éxito")
        var movies: [Movie]?

        sut.getMovies(filter: .topRated) { fetchedMovies in
            movies = fetchedMovies
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(movies, "La matriz de películas no debe ser nil")
        XCTAssertTrue(movies!.count > 0, "La matriz de películas no debe estar vacía")
    }
    
    func testGetMoviesUpcoming() throws {
        let expectation = self.expectation(description: "Películas obtenidas con éxito")
        var movies: [Movie]?

        sut.getMovies(filter: .upcoming) { fetchedMovies in
            movies = fetchedMovies
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(movies, "La matriz de películas no debe ser nil")
        XCTAssertTrue(movies!.count > 0, "La matriz de películas no debe estar vacía")
    }
    
    func testGetMoviesSimilar() throws {
        let expectation = self.expectation(description: "Películas obtenidas con éxito")
        var movies: [Movie]?

        sut.getRelatedMovies(filter: .similar, movieID: 603) { fetchedMovies in
            movies = fetchedMovies
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(movies, "La matriz de películas no debe ser nil")
        XCTAssertTrue(movies!.count > 0, "La matriz de películas no debe estar vacía")
    }
    
    func testGetMoviesRecommendations() throws {
        let expectation = self.expectation(description: "Películas obtenidas con éxito")
        var movies: [Movie]?

        sut.getRelatedMovies(filter: .recommendations, movieID: 603) { fetchedMovies in
            movies = fetchedMovies
            expectation.fulfill()
        }

        waitForExpectations(timeout: 5, handler: nil)

        XCTAssertNotNil(movies, "La matriz de películas no debe ser nil")
        XCTAssertTrue(movies!.count > 0, "La matriz de películas no debe estar vacía")
    }
    
    func testGetURLForTrending() {
        let urlStringExpected = "https://api.themoviedb.org/3/trending/movie/day?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1"
        let result = sut.getUrlFilter(.trending)
        XCTAssertEqual(result, urlStringExpected)
    }
    
    func testGetURLForNowPlaying() {
        let urlStringExpected = "https://api.themoviedb.org/3/movie/now_playing?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1"
        let result = sut.getUrlFilter(.nowPlaying)
        XCTAssertEqual(result, urlStringExpected)
    }
    
    func testGetURLForPopular() {
        let urlStringExpected = "https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1"
        let result = sut.getUrlFilter(.popular)
        XCTAssertEqual(result, urlStringExpected)
    }
    
    func testGetURLForTopRated() {
        let urlStringExpected = "https://api.themoviedb.org/3/movie/top_rated?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1"
        let result = sut.getUrlFilter(.topRated)
        XCTAssertEqual(result, urlStringExpected)
    }
    
    func testGetURLForUpcoming() {
        let urlStringExpected = "https://api.themoviedb.org/3/movie/upcoming?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1"
        let result = sut.getUrlFilter(.upcoming)
        XCTAssertEqual(result, urlStringExpected)
    }
    
    func testGetURLForSimilar() {
        let urlStringExpected = "https://api.themoviedb.org/3/movie/603/similar?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1"
        let result = sut.getUrlFilter(.similar, 603)
        XCTAssertEqual(result, urlStringExpected)
    }
    
    func testGetURLForRecommendations() {
        let urlStringExpected = "https://api.themoviedb.org/3/movie/603/recommendations?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&region=MX&page=1"
        let result = sut.getUrlFilter(.recommendations, 603)
        XCTAssertEqual(result, urlStringExpected)
    }
}
