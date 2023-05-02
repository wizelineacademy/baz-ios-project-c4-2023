//
//  MovieInteractorTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 26/04/23.
//

import Foundation
import XCTest

@testable import BAZProject

final class MovieInteractorTests: XCTest {
    
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
