//
//  RequestHandlerErrorTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import XCTest
@testable import BAZProject

final class RequestHandlerErrorTests: XCTestCase {

    func test_requestBuilder_shouldNotBeNil() throws {
        let error = RequestHandlerError.requestBuilder
        
        XCTAssertNotNil(error.errorDescription)
    }
    
    func test_badResponse_shouldNotBeNil() throws {
        let error = RequestHandlerError.badResponse
        
        XCTAssertNotNil(error.errorDescription)
    }

}
