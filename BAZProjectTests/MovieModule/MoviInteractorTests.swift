//
//  MoviInteractorTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import XCTest

@testable import BAZProject

final class MoviInteractorTests: XCTestCase {
        
    var sut: MovieInteractorInputProtocol!
    var remoteData: MovieRemoteDataManagerMock!
        
    override func setUp() {
        super.setUp()
        sut = MovieInteractor()
        remoteData = MovieRemoteDataManagerMock()
        sut.remoteDatamanager = remoteData
    }

    override func tearDown() {
        super.tearDown()
        sut = nil
        remoteData = nil
    }
        
    func testMoviesFetch() {
        sut.fetchMovies()
        XCTAssert(remoteData.calls.contains(.fetchMovies))
    }
}
