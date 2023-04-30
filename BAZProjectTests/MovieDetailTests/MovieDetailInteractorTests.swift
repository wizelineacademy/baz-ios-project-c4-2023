//
//  MovieDetailInteractorTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 29/04/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailInteractorTests: XCTestCase {
    private var sut: MovieDetailInteractor!
    private var remoteData: MovieDetailDataManagerMock!
    private var presenter: MovieDetailPresenterMock!

    override func setUp() {
        super.setUp()
        sut = MovieDetailInteractor()
        remoteData = MovieDetailDataManagerMock()
        presenter = MovieDetailPresenterMock()
        sut.presenter = presenter
        sut.remoteData = remoteData
    }
    
    override func tearDown() {
        sut = nil
        remoteData = nil
        presenter = nil
        super.tearDown()
    }
    
    func test_fetchForActors_callsRemoteDataRequestActors() {
        let endPoint: Endpoint = .actors(idMovie: 0)
        
        sut.fetchForActors(endPoint)
        
        XCTAssert(remoteData.calls.contains(.requestActors))
    }
    
    func test_fetchForSimilarMovies_callsRequestSimilarMovies() {
        let endPoint: Endpoint = .similar(idMovie: 0)
        
        sut.fetchForSimilarMovies(endPoint)
        
        XCTAssert(remoteData.calls.contains(.requestSimilarMovies))
    }
    
    func test_fetchForRecommendedMovies_callsRequestRecommendedMovies(){
        let endPoint: Endpoint = .recommended(idMovie: 0)
        
        sut.fetchForRecommendedMovies(endPoint)
        
        XCTAssert(remoteData.calls.contains(.requestRecommendedMovies))
    }
    
    func test_fetchUserReviews_callsRequestUserReviews() {
        let endPoint: Endpoint = .reviews(idMovie: 0)
        
        sut.fetchUserReviews(endPoint)
        
        XCTAssert(remoteData.calls.contains(.requestUserReviews))
    }
    
    func test_fetchMovieBanner_callsRequestImageData(){
//        let expectation = XCTestExpectation(description: "Wait for request banner completion")
//        remoteData.expectation = expectation
        
        sut.fetchMovieBanner("")
        
//        wait(for: [expectation], timeout: 0.2)
        XCTAssert(remoteData.calls.contains(.requestImageData))
    }
    
    func test_fetchSimilarImageFrom_callsRequestMoviesImageData() {
        let movies = [MovieFakes().movieModel]
        
        sut.fetchSimilarImageFrom(movies)
        
        XCTAssert(remoteData.calls.contains(.requestMoviesImageData))
    }
    
    func test_fetchRecommendedImageFrom_callsRequestMoviesImageData() {
        let movies = [MovieFakes().movieModel]
        
        sut.fetchSimilarImageFrom(movies)
        
        XCTAssert(remoteData.calls.contains(.requestMoviesImageData))
    }
    
    func test_fetchImageProfile_callsRequestProfileImageData() {
        let actors = [Actor(adult: true, gender: 1, id: 0, knownForDepartment: "", name: "", originalName: "", popularity: 0, profilePath: "", castId: 1, character: "", creditId: "", order: 0)]
        
        sut.fetchImageProfile(actors)
        
        XCTAssert(remoteData.calls.contains(.requestProfileImageData))
    }
    
    func test_fetchUserAvatar_callsRequestUserImageData() {
        let reviews = [Review(author: "", authorDetails: nil, content: "", createdAt: "", id: "", updatedAt: "", url: "")]
        
        sut.fetchUserAvatar(reviews)
        
        XCTAssert(remoteData.calls.contains(.requestUserImageData))
    }
    
    func test_handleActorsFetchedList_callsOnReceivedActors() {
        let movieCast = MovieCast(id: 0, cast: [])
        
        sut.handleActorsFetchedList(movieCast)
        
        XCTAssert(presenter.calls.contains(.onReceivedActors))
    }
    
    func test_handleSimilarMoviesFetchedList_callsOnReceivedSimilarMovies() {
        let moviesResult = MovieFakes().movieResult
        
        sut.handleSimilarMoviesFetchedList(moviesResult)
        
        XCTAssert(presenter.calls.contains(.onReceivedSimilarMovies))
    }
    
    func test_handleRecommendedMoviesFetchedList_callsOnReceivedRecommendedMovies() {
        let moviesResult = MovieFakes().movieResult
        
        sut.handleRecommendedMoviesFetchedList(moviesResult)
        
        XCTAssert(presenter.calls.contains(.onReceivedRecommendedMovies))
    }
    
    func test_handleUserReviewsFetchedList_callsOnReceivedUserReviews() {
        let reviewList = ReviewResponse(id: 0, page: 0, results: [], totalPages: 0, totalResults: 0)
        
        sut.handleUserReviewsFetchedList(reviewList)
        
        XCTAssert(presenter.calls.contains(.onReceivedUserReviews))
    }
}
