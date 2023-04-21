//
//  TrendingDataTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 20/04/23.
//

import Foundation

import XCTest
@testable import BAZProject

class TrendingDataTests: XCTestCase {
    
    private var sut: TrendingRemoteDataManagerInputProtocol!
    private var interactorMock: TrendingInteractorMock!
    private var serviceMock: ServiceMock!
    private var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        serviceMock = ServiceMock(sessionMock: sessionMock)
        sut = TrendingRemoteDataManager(service: ServiceMock(sessionMock: sessionMock) as ServiceProtocol)
        interactorMock = TrendingInteractorMock()
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
        let urlString = "https://fakeurl.com"
        // When
        sut.fetchMovies()
        expectation.fulfill()
        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssert(interactorMock.calls.contains(.handleerror))
        XCTAssertNotEqual(interactorMock.catchedError, .response,  "error ")
    }
    
    
}


