//
//  TrendingMoviesViewControllerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 25/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesViewControllerTest: XCTestCase {

    private var sut: TrendigMoviesViewControllerMock!
    private var presenter: TrendingMoviesPresenterMock!
    private var restorableState: SearchControllerRestorableState!
    private var movies: [ListMovieProtocol]!
    
    override func setUp() {
        super.setUp()
        presenter = TrendingMoviesPresenterMock(router: TrendingMoviesRouter())
        restorableState = SearchControllerRestorableState()
        
        movies = [Movie(id: 0, title: "ejemplo 1", posterPath: "ejemplo de path 1"),
                  Movie(id: 1, title: "ejemplo 2", posterPath: "ejemplo de path 2"),
                  Movie(id: 2, title: "ejemplo 3", posterPath: "ejemplo de path 3"),
                  Movie(id: 3, title: "ejemplo 4", posterPath: "ejemplo de path 4")]
        
        sut = TrendigMoviesViewControllerMock(presenter: presenter,
                                              restoredState: restorableState,
                                              movies: movies,
                                              searchResultMovies: movies)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_loadData_callsInteractor() {
        sut.loadData(movies: movies)
        XCTAssertEqual(sut.movies.count, movies.count)
        XCTAssertEqual(sut.calls, [.loadData])
    }
    
    func test_loadSearchData() {
        sut.loadSearchData(movies: movies)
        XCTAssertEqual(sut.movies.count, movies.count)
        XCTAssertEqual(sut.calls, [.loadSearchData])
    }

}
