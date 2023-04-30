//
//  MovieDetailRemoteDataTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 29/04/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailRemoteDataTests: XCTestCase {
    private var sut: MovieDetailRemoteDataInputProtocol!
    private var interactor: MovieDetailInteractorMock!
    private var service: ServiceMock!
    private var session: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        session = URLSessionMock()
        service = ServiceMock(sessionMock: session)
        interactor = MovieDetailInteractorMock()
        sut = MovieDetailDataManager(service: service)
        sut.interactor = interactor
    }
    
    override func tearDown() {
        session = nil
        service = nil
        interactor = nil
        sut = nil
        super.tearDown()
    }
    
    func test_requestActors_whenErrorResponse_callsErrorServiceHandler() {
        let expectation = XCTestExpectation(description: "Wait for request actors list completion")
        session.data = Data()
        let endPoint: Endpoint = .actors(idMovie: 0)
        session.expectation = expectation
        
        sut.requestActors(withEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactor.calls.contains(.handleServiceWithError))
    }
    
    func test_requestActors_whenSuccesResponse_callsHandleActorsFetchedList() {
        let statusCode = 200
        let expectation = XCTestExpectation(description: "Wait for completion of \(statusCode)")
        let endPoint: Endpoint = .actors(idMovie: 0)
        let url: URL = URL(fileURLWithPath: "")
        session.urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        session.data = MovieFakes().movieList
        session.expectation = expectation
        
        sut.requestActors(withEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactor.calls.contains(.handleActorsFetchedList))
    }
    
    func test_requestSimilarMovies_whenErrorResponse_callsErrorServiceHandler() {
        let expectation = XCTestExpectation(description: "Wait for request actors list completion")
        session.data = Data()
        let endPoint: Endpoint = .actors(idMovie: 0)
        session.expectation = expectation
        
        sut.requestSimilarMovies(withEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactor.calls.contains(.handleServiceWithError))
    }
    
    func test_requestSimilarMovies_whenSuccesResponse_callsHandleSimilarMoviesFetchedList() {
        let statusCode = 200
        let expectation = XCTestExpectation(description: "Wait for completion of \(statusCode)")
        let endPoint: Endpoint = .actors(idMovie: 0)
        let url: URL = URL(fileURLWithPath: "")
        session.urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        session.data = MovieFakes().movieList
        session.expectation = expectation
        
        sut.requestSimilarMovies(withEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactor.calls.contains(.handleSimilarMoviesFetchedList))
    }
    
    func test_requestRecommendedMovies_whenErrorResponse_callsErrorServiceHandler() {
        let expectation = XCTestExpectation(description: "Wait for request actors list completion")
        session.data = Data()
        let endPoint: Endpoint = .actors(idMovie: 0)
        session.expectation = expectation
        
        sut.requestRecommendedMovies(withEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactor.calls.contains(.handleServiceWithError))
    }
    
    func test_requestRecommendedMovies_whenSuccesResponse_callsHandleRecommendedMoviesFetchedList() {
        let statusCode = 200
        let expectation = XCTestExpectation(description: "Wait for completion of \(statusCode)")
        let endPoint: Endpoint = .actors(idMovie: 0)
        let url: URL = URL(fileURLWithPath: "")
        session.urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        session.data = MovieFakes().movieList
        session.expectation = expectation
        
        sut.requestRecommendedMovies(withEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactor.calls.contains(.handleRecommendedMoviesFetchedList))
    }
    
    func test_requestImageData_callsServiceFetchImageData() {
        sut.requestImageData(urlString: "") { data in }
        
        XCTAssert(service.calls.contains(.fetchImageData))
    }
    
    func test_requestProfileImageData_callsServiceFetchImageData() {
        sut.requestProfileImageData(actors: [Actor(adult: true, gender: 1, id: 1, knownForDepartment: "", name: "", originalName: "", popularity: 0, profilePath: "", castId: 1, character: "", creditId: "", order: 0)]) { array in }
        
        XCTAssert(service.calls.contains(.fetchImageData))
    }
    
    func test_requestMoviesImageData_callsServiceFetchImageData() {
        sut.requestMoviesImageData(movies: [MovieFakes().movieModel]) { array in }
        
        XCTAssert(service.calls.contains(.fetchImageData))
    }
    
    func test_requestUserReviews_whenErrorResponse_callsErrorServiceHandler() {
        let expectation = XCTestExpectation(description: "Wait for request actors list completion")
        session.data = Data()
        let endPoint: Endpoint = .reviews(idMovie: 0)
        session.expectation = expectation
        
        sut.requestUserReviews(withEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactor.calls.contains(.handleServiceWithError))
    }
    
    func test_requestUserReviews_whenSuccesResponse_callsHandleUserReviewsFetchedList() {
        let statusCode = 200
        let expectation = XCTestExpectation(description: "Wait for completion of \(statusCode)")
        let endPoint: Endpoint = .actors(idMovie: 0)
        let url: URL = URL(fileURLWithPath: "")
        session.urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
        session.data = MovieFakes().reviewList
        session.expectation = expectation
        
        sut.requestUserReviews(withEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        print("",interactor.calls)
        XCTAssert(interactor.calls.contains(.handleUserReviewsFetchedList))
    }
    
    func test_requestUserImageData_callsServiceFetchImageData() {
        sut.requestUserImageData(reviews: [Review(author: "", authorDetails: nil, content: "", createdAt: "", id: "", updatedAt: "", url: "")]) { array in }
        
        XCTAssert(service.calls.contains(.fetchImageData))
    }
}
