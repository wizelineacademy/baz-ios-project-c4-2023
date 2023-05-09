//
//  MovieDetailRemoteTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import XCTest
@testable import BAZProject


final class MovieDetailRemoteTests: XCTestCase {
    
    private var sut: MovieDetailRemoteDataManagerInputProtocol!
    private var interactorMock: DetailInteractorMock!
    private var serviceMock: ServiceMock!
    private var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        serviceMock = ServiceMock(sessionMock: sessionMock)
        sut = MovieDetailRemoteDataManager(service: serviceMock)
        interactorMock = DetailInteractorMock()
        sut.fetchMovieDetail(of: 1)
    }
        
    override func tearDown() {
        sut = nil
        sessionMock = nil
        serviceMock = nil
        interactorMock = nil
        super.tearDown()
    }
    
    func testRequestMovieList_whenErrorResponse_callsServiceHandle() {
        let expectation = XCTestExpectation(description: "Wait for request movie detail list completion")
        sessionMock.data = Data()
        sessionMock.expected = expectation
        sut.fetchMovieDetail(of: 1)
            
        XCTAssertFalse(interactorMock.detailCalls.contains(.movieDetailFetched))
    }

}
