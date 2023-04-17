//
//  TrendingBarRemoteDataTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingBarRemoteDataTests: XCTestCase {
    
    private var sut: TrendingBarRemoteDataInputProtocol!
    private var interactorMock: TrendingBarInteractorMock!
    private var serviceMock: ServiceMock!
    private var sessionMock: URLSessionMock!

    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        serviceMock = ServiceMock(sessionMock: sessionMock)
        sut = TrendingBarDataManager(service: serviceMock)
        interactorMock = TrendingBarInteractorMock()
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
        
        sut.requestMovieList(byEndPoint: endPoint)
        
        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactorMock.calls.contains(.handleServiceError))
    }
    
    func testRequestMovieList_whenNoDataError_callsInteractorHandler() {
        let expectation = XCTestExpectation(description: "Wait for request movie list completion")
        let endPoint: Endpoint = .trending
        sessionMock.expectation = expectation

        sut.requestMovieList(byEndPoint: endPoint)

        wait(for: [expectation], timeout: 0.2)
        XCTAssert(interactorMock.calls.contains(.handleServiceError))
        XCTAssertEqual(interactorMock.catchedError, .noData, "Se espera que la petición regrese un error de noData")
    }
    
    func testRequestMovieList_whenStatusCode200_callsHandleTrendingFetchedList() {
        for statusCode in 200...299 {
            let endPoint: Endpoint = .trending
            let expectation = XCTestExpectation(description: "Wait for completion of \(statusCode)")
            let url: URL = URL(fileURLWithPath: "")
            sessionMock.urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            sessionMock.data = MovieFakes().movieList
            sessionMock.expectation = expectation
            
            sut.requestMovieList(byEndPoint: endPoint)
            
            wait(for: [expectation], timeout: 0.1)
            XCTAssert(interactorMock.calls.contains(.handleTrendingFetchedList))
            XCTAssertFalse(interactorMock.calls.contains(.handleServiceError))
        }
    }
    
    func testRequestMovieList_whenStatusCode300to500_callsHandleTrendingFetchedList() {
        for statusCode in 300...500 {
            let endPoint: Endpoint = .trending
            let expectation = XCTestExpectation(description: "Wait for completion of \(statusCode)")
            let url: URL = URL(fileURLWithPath: "")
            sessionMock.urlResponse = HTTPURLResponse(url: url, statusCode: statusCode, httpVersion: nil, headerFields: nil)
            sessionMock.data = MovieFakes().movieList
            sessionMock.expectation = expectation
            
            sut.requestMovieList(byEndPoint: endPoint)
            
            wait(for: [expectation], timeout: 0.1)
            XCTAssertFalse(interactorMock.calls.contains(.handleTrendingFetchedList))
            XCTAssert(interactorMock.calls.contains(.handleServiceError))
            XCTAssertEqual(interactorMock.catchedError, .internalServer, "Se espera que la petición regrese un error de internaServer")
        }
    }
}
