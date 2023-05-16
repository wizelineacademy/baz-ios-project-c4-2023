//
//  TrendingMoviesPresenterTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import XCTest

@testable import BAZProject

final class TrendingMoviesPresenterTest: XCTestCase{
    
    ///Sut
    private var sut: MoviesPresenter!
    
    ///ViewController Fake
    private var viewControllerMock: MoviesViewControllerMock!
    
    ///interactorMock Fake
    private var interactorMock: MoviesInteractorMock!
    
    /// routerMock Fake
    private var routerMock: MoviesRouterMock!
    
    ///Moview Fake
    var movie: Movie = Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)
    
    ///Inicializador de las variables para las unit Test
    override func setUp() {
        super.setUp()
        viewControllerMock = MoviesViewControllerMock(restoredState: SearchControllerRestorableState())
        interactorMock = MoviesInteractorMock(movieAPI: FakeMovieApi(resultType: .sucess))
        routerMock = MoviesRouterMock()
        
        sut = MoviesPresenter(interface: viewControllerMock, interactor: interactorMock, router: routerMock)
    }
    
    ///Se  alimina la instancia de las variables para el test
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewControllerMock = nil
        interactorMock = nil
        routerMock = nil
    }
    
    ///Test que evalua que el presnter envie la informacion al interactor
    func test_getMovies_callsInteractorGetMovies() {
        sut.getMovies()
        interactorMock.getMovies(urlRequest: URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(interactorMock.calls, [.getMovies])
    }

    
    ///Test que evalua que el presnter envie la informacion al interactor
    func test_findMovies() {
        sut.findMovies(for: "textToSearch")
        viewControllerMock.loadSearchData(movies: [movie])
        XCTAssertEqual(viewControllerMock.calls, [.loadSearchData])
    }
    
    ///Test que evalua que el presnter envie la informacion al interactor
    func test_cleanStringForSearch_returnCleanString(){
        let cleantext = sut.cleanStringForSearch("textToSearch")
        let count = cleantext.count
        XCTAssert(count > 3)
    }
    
    ///Test que evalua que el presnter envie la informacion al interactor
    func test_sendToReviews_calls(){
        sut.sendToDetail(movie: movie)
        XCTAssertEqual(routerMock.calls, [.sendToDetail])
    }

}

