//
//  MovieAPITests.swift
//  BAZProjectTests
//
//  Created by Manuel S on 21/04/23.
//

import XCTest
@testable import BAZProject

final class MovieAPITests: XCTestCase {
    
    func test_getMovies_ShouldGiveError() {
        let session = SessionMock()
        let sut = MovieAPI(service: ServiceAPI(session: session))
        let expectedError = NSError(domain: "", code: -666)
        let expectation = XCTestExpectation()
        var actualError: Error?
        session.error = expectedError
        sut.getMovies { _, error in
            actualError = error
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNotNil(actualError)
        
    }
    
}
