//
//  MovieAPITests.swift
//  BAZProjectTests
//
//  Created by Manuel S on 21/04/23.
//

import XCTest
@testable import BAZProject

final class MovieAPITests: XCTestCase {
    
    
    private var sut: MovieAPI!
    private var session: SessionMock!
    
    override func setUp() {
        super.setUp()
        
        session = SessionMock()
        sut = MovieAPI(service: ServiceAPI(session: session))
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_getMovies_ShouldGiveError() {
        //Given
        let expectedError = NSError(domain: "", code: -666)
        let expectation = XCTestExpectation()
        var actualError: Error?
        //Then
        session.error = expectedError
        sut.getMovies(category: .trending) { _, error in
            actualError = error
            expectation.fulfill()
        }
        //When
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(actualError)
    }
    
    func test_getCast_ShouldGiveError() {
        //Given
        let expectedError = NSError(domain: "", code: -666)
        let expectation = XCTestExpectation()
        var actualError: Error?
        //Then
        session.error = expectedError
        sut.getCast(idMovie: 1) { _, error in
            actualError = error
            expectation.fulfill()
        }
        //When
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(actualError)
    }
}
