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
        var errorThrown: RequestHandlerError?
        
        //When
        sut.get(EndpointMock.forOtherTests) { (result) in
            switch result {
            case .failure(let error): errorThrown = error
            case .success: XCTFail("Should be null data error")
            }
        }
        
        //Then
        XCTAssertEqual(errorThrown, .nullData)
    }
    
    func test_get_ErrorShouldBeRequestBuilder() throws {
        //Given
        var errorThrown: RequestHandlerError?
        
        //When
        sut.get(EndpointMock.forRequestFailure) { (result) in
            switch result {
            case .failure(let error): errorThrown = error
            case .success: XCTFail("Should be request builder error")
            }
        }
        
        //Then
        XCTAssertEqual(errorThrown, .requestBuilder)
    }
    
    func test_get_ErrorShouldBeServiceError() throws {
        //Given
        var errorThrown: RequestHandlerError?
        let injectedError = NSError(domain: "", code: -1, userInfo: nil)
        
        //When
        requestSessionMock.error = injectedError
        sut.get(EndpointMock.forOtherTests) { (result) in
            switch result {
            case .failure(let error): errorThrown = error
            case .success: XCTFail("Should be service error")
            }
        }
        
        //Then
        XCTAssertEqual(errorThrown, .serviceError(injectedError))
    }
    
    func test_get_ShouldSucceed() throws {
        //Given
        var errorThrown: RequestHandlerError?
        let injectedData = Data()
        
        //When
        requestSessionMock.data = injectedData
        sut.get(EndpointMock.forOtherTests) { (result) in
            switch result {
            case .failure(let error): errorThrown = error
            case .success: return
            }
        }
        
        //Then
        XCTAssertNil(errorThrown)
    }

}

