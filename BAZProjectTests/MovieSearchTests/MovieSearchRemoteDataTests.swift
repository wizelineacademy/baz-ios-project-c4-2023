//
//  MovieSearchRemoteDataTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import XCTest
@testable import BAZProject

final class MovieSearchRemoteDataTests: XCTestCase {
    private var sut: MovieSearchRemoteDataInputProtocol!
    private var interactorMock: MovieSearchInteractorMock!
    private var serviceMock: ServiceMock!
    private var sessionMock: URLSessionMock!

    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        serviceMock = ServiceMock(sessionMock: sessionMock)
        sut = MovieSearchDataManager(service: serviceMock)
        interactorMock = MovieSearchInteractorMock()
        sut.interactor = interactorMock
    }
    
    override func tearDown() {
        sut = nil
        sessionMock = nil
        serviceMock = nil
        interactorMock = nil
        super.tearDown()
    }
    
    func testRequestMovieList_whenErrorResponse_callsErrorServiceHandle() {
        let expectation = XCTestExpectation(description: "Wait for request movie list completion")
        sessionMock.data = Data()
        let endPoint: Endpoint = .trending
        sessionMock.expectation = expectation
        
        sut.requestSearchMovie(byEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactorMock.calls.contains(.handleServiceError))
    }
    
    func testRequestMovieList_whenNoDataError_callsInteractorHandler() {
        let expectation = XCTestExpectation(description: "Wait for request movie list completion")
        let endPoint: Endpoint = .nowPlaying
        sessionMock.expectation = expectation

        sut.requestSearchMovie(byEndPoint: endPoint)

        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactorMock.calls.contains(.handleServiceError))
        XCTAssertEqual(interactorMock.catchedError, .noData, "Se espera que la petición regrese un error de noData")
    }
    
    func testRequestMovieList_whenStatusCode200_callsHandleTrendingFetchedList() {
        for statusCode in 200...299 {
            let endPoint: Endpoint = .popular
            let expectation = XCTestExpectation(description: "Wait for completion of \(statusCode)")
            let url: URL = URL(fileURLWithPath: "")
            sessionMock.urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            sessionMock.data = MovieFakes().movieList
            sessionMock.expectation = expectation
            
            sut.requestSearchMovie(byEndPoint: endPoint)
            
            wait(for: [expectation], timeout: 0.1)
            XCTAssert(interactorMock.calls.contains(.handleSearchingFetchedList))
            XCTAssertFalse(interactorMock.calls.contains(.handleServiceError))
        }
    }
    
    func testRequestMovieList_whenStatusCode300to500_callsHandleTrendingFetchedList() {
        for statusCode in 300...500 {
            let endPoint: Endpoint = .search(query: "")
            let expectation = XCTestExpectation(description: "Wait for completion of \(statusCode)")
            let url: URL = URL(fileURLWithPath: "")
            sessionMock.urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            sessionMock.data = MovieFakes().movieList
            sessionMock.expectation = expectation
            
            sut.requestSearchMovie(byEndPoint: endPoint)
            
            wait(for: [expectation], timeout: 0.1)
            XCTAssertFalse(interactorMock.calls.contains(.handleSearchingFetchedList))
            XCTAssert(interactorMock.calls.contains(.handleServiceError))
            XCTAssertEqual(interactorMock.catchedError, .internalServer, "Se espera que la petición regrese un error de internaServer")
        }
    }
}
