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
        
        let expectedObject1 = MovieArray(results: [Movie(id: 3465, title: "df_SAWERQ", posterPath: "path//")])
        let expectedObject2 = MovieArray(results: [Movie(id: 3465, title: "df_SAWERQ")])
        
        XCTAssertEqual(decodedMovie1, expectedObject1)
        XCTAssertEqual(decodedMovie2, expectedObject2)
        XCTAssertEqual(decodedMovie3, expectedObject1)
    }
    
}
