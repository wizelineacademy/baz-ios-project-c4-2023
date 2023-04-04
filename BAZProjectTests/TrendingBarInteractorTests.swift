//
//  TrendingBarInteractorTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 28/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingBarInteractorTests: XCTestCase {
    
    private var sut: TrendingBarInteractor!
    private var remoteDataManager: TrendingBarRemoteDataManagerMock!
    private var presenter: TrendingBarPresenterMock!

    override func setUpWithError() throws {
        sut = TrendingBarInteractor()
        remoteDataManager = TrendingBarRemoteDataManagerMock()
        presenter = TrendingBarPresenterMock()
        sut.remoteData = remoteDataManager
        sut.presenter = presenter
    }

    override func tearDown() {
        sut = nil
        remoteDataManager = nil
        presenter = nil
        super.tearDown()
    }

    func testRequestMovieList() {
        let endPoint: Endpoint = .trending
        sut.fetchMovieList(endPoint)
        XCTAssert(remoteDataManager.calls.contains(.requestMovieList))
    }
    
    func testRequestImageData() {
        let movie = MovieFakes().movieResult.results![0]
        sut.fetchImageFrom(movie)
        XCTAssert(remoteDataManager.calls.contains(.requestImageData))
    }
    
    func test_handleTrendingFetchedList_callsPresenterOnreceivedTrendingList() {
        let moviesResult = MovieFakes().movieResult
        
        sut.handleTrendingFetchedList(moviesResult)
        
        XCTAssertEqual(presenter.calls, [.onReceivedTrendingList])
    }
    
    func test_handleServiceError_callsOnreceivedWithError() {
        let serviceError = ServiceError.parsingData
        
        sut.handleService(error: serviceError)
        
        XCTAssertEqual(presenter.calls, [.onReceivedWithError])
    }
}
