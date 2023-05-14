//
//  TrendingMoviesPresenterTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import XCTest

@testable import BAZProject

final class TrendingMoviesPresenterTest: XCTestCase{
    
    private var sut: MoviesPresenter!
    private var viewControllerMock: MoviesViewControllerMock!
    private var interactorMock: MoviesInteractorMock!
    private var routerMock: MoviesRouterMock!
    var movie: Movie = Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)
    
    override func setUp() {
        super.setUp()
        viewControllerMock = MoviesViewControllerMock(restoredState: SearchControllerRestorableState())
        interactorMock = MoviesInteractorMock(movieAPI: FakeMovieApi(resultType: .sucess))
        routerMock = MoviesRouterMock()
        
        sut = MoviesPresenter(interface: viewControllerMock, interactor: interactorMock, router: routerMock)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewControllerMock = nil
        interactorMock = nil
        routerMock = nil
    }
    
    func test_getMovies_callsInteractorGetMovies() {
        sut.getMovies()
        interactorMock.getMovies(urlRequest: URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(interactorMock.calls, [.getMovies])
    }

    
    func test_findMovies() {
        sut.findMovies(for: "textToSearch")
        viewControllerMock.loadSearchData(movies: [movie])
        XCTAssertEqual(viewControllerMock.calls, [.loadSearchData])
    }
    
    func test_cleanStringForSearch_returnCleanString(){
        let cleantext = sut.cleanStringForSearch("textToSearch")
        let count = cleantext.count
        XCTAssert(count > 3)
    }
    
    func test_sendToReviews_calls(){
        sut.sendToDetail(movie: movie)
        XCTAssertEqual(routerMock.calls, [.sendToDetail])
    }

}

