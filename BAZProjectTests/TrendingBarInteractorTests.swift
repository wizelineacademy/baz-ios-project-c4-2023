//
//  TrendingBarInteractorTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingBarInteractorTests: XCTestCase {
    
    var sut: TrendingBarInteractorInputProtocol!
    var remoteDataManager: TrendingBarRemoteDataManagerMock!

    override func setUpWithError() throws {
        sut = TrendingBarInteractor()
        remoteDataManager = TrendingBarRemoteDataManagerMock()
        sut.remoteData = remoteDataManager
    }

    override func tearDown() {
        sut = nil
        remoteDataManager = nil
        super.tearDown()
    }

    func testRequestMovieList() {
        let endPoint: Endpoint = .trending
        sut.fetchMovieList(endPoint)
        XCTAssert(remoteDataManager.calls.contains(.requestMovieList))
    }
    
    func testRequestImageData() {
        let urlString = "https://image.tmdb.org/t/p/w500/l3oFyC0wZiOmYRqesDLOmsMMDsf.jpg"
        sut.fet
    }

}
