//
//  ApiTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 25/04/23.
//

import XCTest
@testable import BAZProject

final class ApiTest: XCTestCase {

    private var fakeMovies: [ListMovieProtocol]!
    private var sut: FakeMovieApi!
    
    override func setUp() {
        super.setUp()
        fakeMovies = []
        sut = FakeMovieApi(resultType: .sucess)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovies = nil
    }
    
    func test_ErrorApis(){
        let error = ApiError.defaultError
        XCTAssertEqual(error.localizedDescription, "Error por defecto")
    }
}
