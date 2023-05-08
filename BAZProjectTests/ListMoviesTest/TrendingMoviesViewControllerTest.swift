//
//  TrendingMoviesViewControllerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 25/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesViewControllerTest: XCTestCase {

    private var sut: MoviesViewControllerMock!
    private var presenter: MoviesPresenterMock!
    private var restorableState: SearchControllerRestorableState!
    private var movies: [ListMovieProtocol]!
    
    override func setUp() {
        super.setUp()
        presenter = MoviesPresenterMock(router: MoviesRouter())
        restorableState = SearchControllerRestorableState()
        
        movies = [Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10, isFavorite: false)]
        
        sut = MoviesViewControllerMock(presenter: presenter,
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
