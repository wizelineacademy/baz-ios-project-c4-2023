//
//  MovieDatTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import Foundation
import XCTest
@testable import BAZProject

class MovieDataTests: XCTestCase {
    
    private var sut: MovieRemoteDataManagerInputProtocol!
    private var interactorMock: MovieInteractorMock!
    private var serviceMock: ServiceMock!
    private var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        serviceMock = ServiceMock(sessionMock: sessionMock)
        sut = MovieRemoteDataManager(service: ServiceMock(sessionMock: sessionMock), endpoint: .upcomingMovies)
        interactorMock = MovieInteractorMock()
        sut.remoteRequestHandler = interactorMock
    }
    
    override func tearDown() {
        sut = nil
        interactorMock = nil
        sessionMock = nil
        serviceMock = nil
        super.tearDown()
    }
    
    func testRequestTrending_whenResponseError_callsHandleServiceError() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for Trending completion")
        sessionMock.data = Data()
        // When
        sut.fetchMovies()
        expectation.fulfill()
        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssert(interactorMock.calls.contains(.handleService))
        XCTAssertEqual(interactorMock.catchedError, .response, "Se espera que el código regrese del tipo ServiceError.response")
    }
    
    func testRequest_whenNoDataError_callsInteractorHandler() {
        // Given
        let expectation = XCTestExpectation(description: "Wait for requestPokemonBlock completion")
        // When
        sut.fetchMovies()
        expectation.fulfill()
        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssert(interactorMock.calls.contains(.handleService))
        XCTAssertEqual(interactorMock.catchedError, .noData, "Se espera que el código regrese del tipo ServiceError.noData")
    }
    
}


