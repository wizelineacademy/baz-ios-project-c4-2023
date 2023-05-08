//
//  SearcRemoteTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import XCTest
@testable import BAZProject

final class SearcRemoteTests: XCTestCase {
    
    private var sut: SearchRemoteDataManagerInputProtocol!
    private var interactorMock: SearchInteractorMock!
    private var serviceMock: ServiceMock!
    private var sessionMock: URLSessionMock!
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        serviceMock = ServiceMock(sessionMock: sessionMock)
        sut = SearchRemoteDataManager(service: serviceMock)
        interactorMock = SearchInteractorMock()
        sut.fetchSearchResults(with: "")
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
        sessionMock.expected = expectation
        sut.fetchSearchResults(with: "")
            
        XCTAssertFalse(interactorMock.callsSearch.contains(.fetchSearchResults))
        }
}
