//
//  DecoderTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import XCTest
@testable import BAZProject

final class DecoderTests: XCTestCase {
    
    func test_ShouldDecodeSuccessfully() throws {
        let decodedMovie1 = try MovieArray(data: DecodableMovies.completeData)
        let decodedMovie2 = try MovieArray(data: DecodableMovies.missingData)
        let decodedMovie3 = try MovieArray(data: DecodableMovies.extraData)
        
        XCTAssertNotNil(decodedMovie1)
        XCTAssertNotNil(decodedMovie2)
        XCTAssertNotNil(decodedMovie3)
    }
    
}
