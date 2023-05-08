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
    private var interactorMock: MovieDetailInteractorMock!
    private var routerMock: MovieDetailRouterMock!
    private var fakeMovie: Movie!
    
    override func setUp() {
        super.setUp()
        fakeMovie = Movie(id: 123456, title: "Ejmplo", posterPath: "Ejmplo", adult: false, genreIDS: [], originalLanguage: "Ejmplo", originalTitle: "Ejmplo", overview: "Ejmplo", popularity: 1.0, releaseDate: "Ejmplo", video: false, voteAverage: 1.0, voteCount: 1)
        viewControllerMock = MovieDetailViewconrollerMock()
        interactorMock = MovieDetailInteractorMock(presenter: sut)
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
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    func test_getRecomendationcallsInteractorGetRecomendation() {
        sut.getRecomendation()
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    func test_getCast_callsInteractorGetCast() {
        sut.getCast()
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    func test_getReviews_callsInteractorGetReviews() {
        sut.getReviews()
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    func test_findFavoriteMovie_callsInteractorGetReviews() {
        sut.findFavoriteMovie()
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
    }
    
    func test_favoriteMovie_callsInteractorGetReviews() {
        sut.favoriteMovie()
        XCTAssertNotNil(sut.movie)
        XCTAssertEqual(sut.movie.id, fakeMovie.id)
        
    }
    


}
