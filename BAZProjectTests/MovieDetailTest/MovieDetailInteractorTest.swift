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
    private var fakePresenter: MovieDetailPresenterMock!
    private var presenter: MovieDetailPresenter!
    private var view: MoviewDetailViewProtocol!
    
    private var movies: Movie = Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)
    private var listMovie: [Movie]!
    
    
    override func setUp() {
        fakeMovieApi = FakeMovieApi(resultType: .sucess)
        sut = MovieDetailInteractor(movieAPI: fakeMovieApi, userDefault: UserDefaultManager())
        listMovie = [movies]
        fakePresenter = MovieDetailPresenterMock(movie: movies, interface: MovieDetailViewconrollerMock(), interactor: MovieDetailInteractorMock(), router: MovieDetailRouterMock())
        view = MovieDetailViewconrollerMock()
        
        presenter = MovieDetailPresenter(movie: movies, interface: view, interactor: MovieDetailInteractor(movieAPI: FakeMovieApi(resultType: .sucess), userDefault: UserDefaultManager()), router: MovieDetailRouterMock())
        sut.presenter = fakePresenter
    }
    
    override func tearDown() {
        sut = nil
        fakePresenter = nil
        listMovie = nil
    }
    

    
    func test_Similiar_result_success() {
        let movieResult = MovieResult(results: listMovie)

        let result:Result<MovieResult?, Error> = .success(movieResult)
        
        sut.handlerGetSimilarMovieResult(result: result)
        presenter.setSimilarMovies(movies: movieResult.results ?? [])
        XCTAssertTrue(fakePresenter.calls.contains(.setSimilarMovies))
    }

    func test_Similiar_result_failure() {
        let resultError:Result<MovieResult?, Error> = .failure(ApiError.defaultError)
        
        sut.handlerGetSimilarMovieResult(result: resultError)

        XCTAssertFalse(fakePresenter.calls.contains(.setSimilarMovies))
    }
    
    func test_handlerGetRecomendMovieResult() {
        
        let movieResult = MovieResult(results: listMovie)
        
        let result:Result<MovieResult?, Error> = .success(movieResult)
        
        sut.handlerGetRecomendMovieResult(result: result)
        presenter.setRecomendedMovies(movies: movieResult.results ?? [])
        XCTAssertTrue(fakePresenter.calls.contains(.setRecomendedMovies))
        
    }
    
    func test_handlerGetRecomendMovieResult_failure() {
        let resultError:Result<MovieResult?, Error> = .failure(ApiError.defaultError)
        
        sut.handlerGetRecomendMovieResult(result: resultError)
        
        XCTAssertFalse(fakePresenter.calls.contains(.setRecomendedMovies))
    }
    
    
    func test_handlerGetCastResult(result: Result<CastResult?, Error>) {
        
        let cast = [Cast(adult: false, gender: 0, id: 0, knownForDepartment: "ejemplo", name: "ejemplo", originalName: "ejemplo", popularity: 0.0, creditID: "ejemplo")]
        
        let castResult = CastResult(id: 0, cast: cast, crew: cast)
        
        let result:Result<CastResult?, Error> = .success(castResult)
        
        sut.handlerGetCastResult(result: result)
        presenter.setCast(cast)
        XCTAssertTrue(fakePresenter.calls.contains(.setCast))
    }
    
    func test_handlerGetCastResult_failure() {
        let resultError:Result<CastResult?, Error> = .failure(ApiError.defaultError)
        
        sut.handlerGetCastResult(result: resultError)
        
        XCTAssertFalse(fakePresenter.calls.contains(.setCast))
    }
    
    func test_handlerGetReviewResult(result: Result<ReviewResult?, Error>) {
        let autor = AuthorDetails(name: "ejemplo", username: "ejemplo")
        let review = [Review(author: "ejemplo", authorDetails: autor, content: "ejemplo", createdAt: "ejemplo", id: "ejemplo", updatedAt: "ejemplo", url: "ejemplo")]
        
        let reviewResult = ReviewResult(id: 0, page: 0, results: review, totalPages: 0, totalResults: 0)
        
        let result:Result<ReviewResult?, Error> = .success(reviewResult)
        
        sut.handlerGetReviewResult(result: result)
        presenter.setReviews(review)
        XCTAssertTrue(fakePresenter.calls.contains(.setReviews))
    }
    
    func test_handlerGetReviewResult_failure() {
        let resultError:Result<ReviewResult?, Error> = .failure(ApiError.defaultError)
        
        sut.handlerGetReviewResult(result: resultError)
        
        XCTAssertFalse(fakePresenter.calls.contains(.setReviews))
    }
    

}
