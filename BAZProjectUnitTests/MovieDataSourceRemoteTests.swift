//
//  MovieDataSourceRemoteTests.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import XCTest
@testable import BAZProject

final class MovieDataSourceRemoteTests: XCTestCase {

    var sut: MovieDataSourceRemote!

    override func setUp() {
        super.setUp()
        sut = MovieDataSourceRemote()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testGetCast() {
        let expectation = XCTestExpectation(description: "Obtener reparto")
        let movieID = 123
        sut.getCast(movieID: movieID) { actors in
            XCTAssertFalse(actors.isEmpty, "Los actores no deben estar vacíos")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }

    func testGetReviews() {
        let expectation = XCTestExpectation(description: "Obtener reseñas")
        let movieID = 603
        sut.getReviews(movieID: movieID) { reviews in
            XCTAssertFalse(reviews.isEmpty, "Las reseñas no deben estar vacías")
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
}
