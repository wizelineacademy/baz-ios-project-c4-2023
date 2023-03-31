//
//  RequestHandlerUnitTests.swift
//  RequestHandlerUnitTests
//
//  Created by gescarcega on 29/03/23.
//

import XCTest
@testable import BAZProject

final class RequestHandlerUnitTests: XCTestCase {
    
    var sut: RequestHandler!
    var requestSessionMock: RequestSessionMock!

    override func setUp() {
        super.setUp()
        requestSessionMock = RequestSessionMock()
        sut = RequestHandler(withSession: requestSessionMock)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_get_ErrorShouldBeNullData() throws {
        //Given
        let expectation = XCTestExpectation()
        var errorThrown: RequestHandlerError?
        
        //When
        sut.get(EndpointMock()) { (result) in
            switch result {
            case .failure(let error): errorThrown = error
            case .success: break
            }
        }
        
        //Then
        XCTAssertEqual(errorThrown, .nullData)
    }

}

