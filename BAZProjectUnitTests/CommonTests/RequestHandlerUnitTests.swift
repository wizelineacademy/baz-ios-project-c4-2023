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
    
    func test_get_ErrorShouldBeRequestBuilder() async throws {
        //Given
        var errorThrown: RequestHandlerError!
        
        //When
        do {
            let _ = try await sut.get(EndpointMock.forRequestFailure)
            XCTFail("Should throw request builder error error")
        } catch {
            errorThrown = (error as! RequestHandlerError)
        }
        
        //Then
        XCTAssertEqual(errorThrown, .requestBuilder)
    }
    
    func test_get_ErrorShouldBeServiceError() async {
        //Given
        var errorThrown: RequestHandlerError!
        let injectedError = HTTPURLResponse(url: URL(string: "file://")!, statusCode: 404, httpVersion: nil, headerFields: nil)!
        
        //When
        requestSessionMock.urlResponse = injectedError
        do {
            let _ = try await sut.get(EndpointMock.forOtherTests)
            XCTFail("Should throe badResponse error")
        } catch {
            errorThrown = (error as! RequestHandlerError)
        }
        
        //Then
        XCTAssertEqual(errorThrown, .badResponse)
    }
    
    func test_get_ShouldSucceed() async throws {
        //Given
        let _ = try await sut.get(EndpointMock.forOtherTests)
    }

}

