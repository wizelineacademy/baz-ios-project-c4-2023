//
//  MovieDetailPresenterTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import XCTest

@testable import BAZProject

final class MovieDetailPresenterTest: XCTestCase {

    private var sut: MoviewDetailPresenterProtocol!
    private var viewControllerMock: MovieDetailViewconrollerMock!
    private var interactorMock: MovieDetailInteractor!
    private var routerMock: MovieDetailRouterMock!
    private var fakeMovie: Movie!
    
    override func setUp() {
        super.setUp()
        fakeMovie = Movie(id: 123456, title: "Ejmplo", posterPath: "Ejmplo", adult: false, genreIDS: [], originalLanguage: "Ejmplo", originalTitle: "Ejmplo", overview: "Ejmplo", popularity: 1.0, releaseDate: "Ejmplo", video: false, voteAverage: 1.0, voteCount: 1)
        viewControllerMock = MovieDetailViewconrollerMock()
        interactorMock = MovieDetailInteractor(movieAPI: FakeMovieApi(resultType: .sucess), userDefault: UserDefaultManager())
        routerMock = MovieDetailRouterMock()
        sut = MovieDetailPresenter(movie: fakeMovie, interface: viewControllerMock, interactor: interactorMock, router: routerMock)
        
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        viewControllerMock = nil
        interactorMock = nil
        routerMock = nil
    }
    
    func test_getSimilars_callsInteractorGetSimilar() {
        sut.getSimilar()
        interactorMock.getSimilar(URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    func test_getRecomendationcallsInteractorGetRecomendation() {
        sut.getRecomendation()
        interactorMock.getRecomendation(URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    func test_getCast_callsInteractorGetCast() {
        sut.getCast()
        interactorMock.getCast(URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    func test_getReviews_callsInteractorGetReviews() {
        sut.getReviews()
        interactorMock.getReviews(URLRequest(url: URL(string: "www.google.com")!))
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    func test_findFavoriteMovie_callsInteractorGetReviews() {
        sut.isFavorite()
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    


}
