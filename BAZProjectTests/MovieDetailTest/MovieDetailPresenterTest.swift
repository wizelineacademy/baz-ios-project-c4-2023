//
//  MovieDetailPresenterTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import XCTest

@testable import BAZProject

final class MovieDetailPresenterTest: XCTestCase {
    
    ///Sut
    private var sut: MoviewDetailPresenterProtocol!
    
    ///ViewController Fake
    private var viewControllerMock: MovieDetailViewconrollerMock!
    
    ///interactorMock Fake
    private var interactorMock: MovieDetailInteractor!
    
    /// routerMock Fake
    private var routerMock: MovieDetailRouterMock!
    
    ///Moview Fake
    private var fakeMovie: Movie!
    
    ///Inicializador de las variables para las unit Test
    override func setUp() {
        super.setUp()
        fakeMovie = Movie(id: 123456, title: "Ejmplo", posterPath: "Ejmplo", adult: false, genreIDS: [], originalLanguage: "Ejmplo", originalTitle: "Ejmplo", overview: "Ejmplo", popularity: 1.0, releaseDate: "Ejmplo", video: false, voteAverage: 1.0, voteCount: 1)
        viewControllerMock = MovieDetailViewconrollerMock()
        interactorMock = MovieDetailInteractor(movieAPI: FakeMovieApi(resultType: .sucess), userDefault: UserDefaultManager())
        routerMock = MovieDetailRouterMock()
        sut = MovieDetailPresenter(movie: fakeMovie, interface: viewControllerMock, interactor: interactorMock, router: routerMock)
        
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
    func test_getSimilars_callsInteractorGetSimilar() {
        sut.getSimilar()
        interactorMock.getSimilar(URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    ///Test que evalua que el metodo  getRecomendation del presnter envie la informacion al interactor
    func test_getRecomendationcallsInteractorGetRecomendation() {
        sut.getRecomendation()
        interactorMock.getRecomendation(URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    ///Test que evalua que el metodo getCast presnter envie la informacion al interactor
    func test_getCast_callsInteractorGetCast() {
        sut.getCast()
        interactorMock.getCast(URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    ///Test que evalua que el metodo getReviews  presnter envie la informacion al interactor
    func test_getReviews_callsInteractorGetReviews() {
        sut.getReviews()
        interactorMock.getReviews(URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    ///Test que evalua que el metodo  findFavoriteMovie presnter envie la informacion al interactor
    func test_findFavoriteMovie_callsInteractorGetReviews() {
        sut.isFavorite()
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    ///Test que evalua que el metodo setCast  presnter envie la informacion al interactor
    func test_setCast_calls() {
        sut.setCast([Cast(adult: false, gender: 0, id: 0, knownForDepartment: "ejemplo", name: "ejemplo", originalName: "ejemplo", popularity: 0.0, creditID: "ejemplo")])
        
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    ///Test que evalua que el metodo setReviews presnter envie la informacion al interactor
    func test_setReviews_calls() {
        let autor = AuthorDetails(name: "ejemplo", username: "ejemplo")
        sut.setReviews([Review(author: "ejemplo", authorDetails: autor, content: "ejemplo", createdAt: "ejemplo", id: "ejemplo", updatedAt: "ejemplo", url: "ejemplo")])
        
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    ///Test que evalua que el metodo sendToReviews presnter envie la informacion al Roter
    func test_sendToReviews() {
        let autor = AuthorDetails(name: "ejemplo", username: "ejemplo")
        sut.sendToReviews(reviews: [Review(author: "ejemplo", authorDetails: autor, content: "ejemplo", createdAt: "ejemplo", id: "ejemplo", updatedAt: "ejemplo", url: "ejemplo")])
        
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }


}
