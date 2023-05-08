//
//  MovieDetailInteractorTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailInteractorTests: XCTestCase {
    
    var sut: MovieDetailInteractorInputProtocol!
    var remoteData: DetailInteractorDataManagerMock!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailInteractor()
        remoteData = DetailInteractorDataManagerMock()
        sut.remoteDatamanager = remoteData
    }

    override func tearDown() {
       super.tearDown()
        sut = nil
        remoteData = nil
    }
    
    func testfetchMovieDetail(){
        sut.fetchMovieDetail(of: 1)
        XCTAssert(remoteData.detailcalls.contains(.fetchSearchResults))
    }
    
    func testsaveMovieFavorites(){
        sut.saveFavoriteMovie(of: 1)
        XCTAssertFalse(remoteData.detailcalls.contains(.fetchSearchResults))
    }
    
    func testDeleteMovieFavorites(){
        sut.deleteToFavoriteMovie(of: 1)
        XCTAssertFalse(remoteData.detailcalls.contains(.fetchSearchResults))
    }

}
