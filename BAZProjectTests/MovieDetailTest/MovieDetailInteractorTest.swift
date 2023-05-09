//
//  MovieDetailInteractorTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailInteractorTest: XCTestCase {
    
    var sut: MovieDetailInteractor!
    private var fakeMovieApi: FakeMovieApi!
    private var presenter: MovieDetailPresenterMock!
    private var movies: ListMovieProtocol!
    
    
    override func setUp() {
        fakeMovieApi = FakeMovieApi(resultType: .sucess)
        sut = MovieDetailInteractor(movieAPI: fakeMovieApi)
        movies = Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10, isFavorite: false)
        presenter = MovieDetailPresenterMock(movie: movies, interface: MovieDetailViewconrollerMock(), interactor: MovieDetailInteractorMock(), router: MovieDetailRouterMock())
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        presenter = nil
        movies = nil
    }
    
    
    func test_getSimilr_callsAPI(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        guard let url = MovieDetailInfo.similar("123").urlRequest else { return }
        fakeMovieApi.fetch(request:url) {(result: Result<MovieResult?, Error>) in
            switch result {
            case .failure(let fail):
                print(fail)
            case .success(let response):
                XCTAssertNotNil(response?.results)
                self.presenter.setSimilarMovies(movies: response?.results ?? [])
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }

}
