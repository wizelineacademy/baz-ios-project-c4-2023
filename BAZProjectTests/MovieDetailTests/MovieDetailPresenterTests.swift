//
//  MovieDetailPresenterTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 29/04/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailPresenterTests: XCTestCase {
    private var sut: MovieDetailPresenter!
    private var detailViewMock: MovieDetailViewControllerMock!
    private var routerMock: MovieDetailRouterMock!
    private var interactorMock: MovieDetailInteractorMock!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailPresenter()
        detailViewMock = MovieDetailViewControllerMock()
        routerMock = MovieDetailRouterMock()
        interactorMock = MovieDetailInteractorMock()
        sut.interactor = interactorMock
        sut.view = detailViewMock
        sut.router = routerMock
    }
    
    override func tearDown() {
        sut = nil
        detailViewMock = nil
        routerMock = nil
        interactorMock = nil
        super.tearDown()
    }
    
    func test_searchForActors_callsFetchForActors() {
        sut.searchForActors(in: 0)
        
        XCTAssertEqual(interactorMock.calls, [.fetchForActors])
    }
    
    func test_searchForSimilarMovies_callsFetchForSimilarMovies() {
        sut.searchForSimilarMovies(of: 0)
        
        XCTAssertEqual(interactorMock.calls, [.fetchForSimilarMovies])
    }
    
    func test_searchForRecommendedMovies_callsFetchForRecommendedMovies() {
        sut.searchForRecommendedMovies(of: 0)
        
        XCTAssertEqual(interactorMock.calls, [.fetchForRecommendedMovies])
    }
    
    func test_getMovieBanner_callsFetchMovieBanner() {
        sut.movieModel.append(MockData().summary)
        
        sut.getMovieBanner()
        
        XCTAssertEqual(interactorMock.calls, [.fetchMovieBanner])
    }
    
    func test_searchForReviews_callsFetchForRecommendedMovies() {
        sut.searchForReviews(for: 0)
        
        XCTAssertEqual(interactorMock.calls, [.fetchUserReviews])
    }
    
    func test_onReceivedActors_callsFetchImageProfile() {
        let movieCast = MovieCast(id: 0, cast: [])
        
        sut.onReceivedActors(with: movieCast)
        
        XCTAssertEqual(interactorMock.calls, [.fetchImageProfile])
    }
    
    func test_onReceivedActorModel_callsReloadMovieDetailInfo() {
        let actor = ActorModel(name: "", profileImage: Data())
        
        sut.onReceivedActorModel(withActorModel: [actor])
        
        XCTAssertEqual(detailViewMock.calls, [.reloadMovieDetailInfo])
    }
    
    func test_onReceivedSimilarMovies_callsFetchSimilarImageFrom() {
        let movies = MovieFakes().movieResult
        
        sut.onReceivedSimilarMovies(with: movies)
        
        XCTAssertEqual(interactorMock.calls, [.fetchSimilarImageFrom])
    }
    
    func test_onReceivedSimilarMoviesModel_callsReloadMovieDetailInfo() {
        let movies = [Movie(id: 0, title: "", posterPath: Data(), summary: "", backdropPath: "", backdropPathData: nil)]
        
        sut.onReceivedSimilarMoviesModel(with: movies)
        
        XCTAssertEqual(detailViewMock.calls, [.reloadMovieDetailInfo])
    }
    
    func test_onReceivedRecommendedMovies_callsFetchRecommendedImageFrom() {
        let movies = MovieFakes().movieResult
        
        sut.onReceivedRecommendedMovies(with: movies)
        
        XCTAssertEqual(interactorMock.calls, [.fetchRecommendedImageFrom])
    }
    
    func test_onReceivedRecommendedMoviesModel_callsReloadMovieDetailInfo() {
        let movies = [Movie(id: 0, title: "", posterPath: Data(), summary: "", backdropPath: "", backdropPathData: nil)]
        
        sut.onReceivedRecommendedMoviesModel(with: movies)
        
        XCTAssertEqual(detailViewMock.calls, [.reloadMovieDetailInfo])
    }
    
    func test_onReceivedMovieBanner_callsReloadMovieDetailInfo() {
        sut.movieModel.append(MockData().summary)
        
        sut.onReceivedMovieBanner(with: Data())
        
        XCTAssertEqual(detailViewMock.calls.first, .reloadMovieDetailInfo)
    }
    
    func test_onReceivedUserReviews_callsFetchUserAvatar() {
        let reviewResponse = ReviewResponse(id: 0, page: 0, results: [], totalPages: 0, totalResults: 0)
        
        sut.onReceivedUserReviews(with: reviewResponse)
        
        XCTAssertEqual(interactorMock.calls, [.fetchUserAvatar])
    }
    
    func test_onReceivedUserReviewModel_callsReloadMovieDetailInfo() {
        let reviewModel = [ReviewModel(name: "", rating: 0, content: "", avatar: nil)]
        
        sut.onReceivedUserReviewModel(with: reviewModel)
        
        XCTAssertEqual(detailViewMock.calls, [.reloadMovieDetailInfo])
    }
    
    func test_onReceivedWithError_callsViewReloadWithError() {
        let error: ServiceError = .internalServer
        
        sut.onReceived(with: error)
        
        XCTAssertEqual(detailViewMock.calls, [.reloadWithError])
    }
    
    func test_MovieDetailModelSummaryTitle() {
        let summary = MockData().summary
        
        let title = summary.title
        
        XCTAssertNotNil(title)
    }
    
    func test_MovieDetailModelStarringTitle() {
        let starring = MockData().starring
        let starring2 = MockData().starring
        
        let title = starring.title
        let items = starring.items
        
        XCTAssertNotNil(title)
        XCTAssertNotNil(items)
        XCTAssert(starring == starring2)
    }
    
    func test_MovieDetailModelSimilarTitle() {
        let similar = MockData().similar
        let similar2 = MockData().similar
        
        let title = similar.title
        
        XCTAssertNotNil(title)
        XCTAssert(similar == similar2)
    }
    
    func test_MovieDetailModelRecommendedTitle() {
        let recommended = MockData().recommended
        let recommended2 = MockData().recommended
        
        let title = recommended.title
        
        XCTAssertNotNil(title)
        XCTAssert(recommended == recommended2)
    }
    
    func test_MovieDetailModelReviewTitle() {
        let review = MockData().review
        let review2 = MockData().review
        
        let title = review.title
        let items = review.items
        
        XCTAssertNotNil(title)
        XCTAssertNotNil(items)
        XCTAssert(review == review2)
        XCTAssertFalse(review < review2)
    }
}
