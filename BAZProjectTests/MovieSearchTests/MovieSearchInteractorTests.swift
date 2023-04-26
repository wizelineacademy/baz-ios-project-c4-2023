//
//  MovieSearchInteractorTests.swift
//  BAZProjectTests
//
//  Created by 989438 on 20/04/23.
//

import XCTest
@testable import BAZProject

final class MovieSearchInteractorTests: XCTestCase {
    private var sut: MovieSearchInteractor!
    private var remoteDataManager: MovieSearchDataManagerMock!
    private var presenter: MovieSearchPresenterMock!
    
    override func setUp() {
        super.setUp()
        sut = MovieSearchInteractor()
        remoteDataManager = MovieSearchDataManagerMock()
        presenter = MovieSearchPresenterMock()
        sut.remoteData = remoteDataManager
        sut.presenter = presenter
    }
    
    override func tearDown() {
        sut = nil
        remoteDataManager = nil
        presenter = nil
        super.tearDown()
    }
    
    func testRequestSearchMovie() {
        let endPoint: Endpoint = .search(query: "")
        
        sut.fetchSearchMovieResults(endPoint)
        
        XCTAssert(remoteDataManager.calls.contains(.requestSearchMovie))
    }
    
    func testRequestImageData() {
        let movie = MovieFakes().movieResult.results![0]
        
        sut.fetchImageFrom(movie)
        
        XCTAssert(remoteDataManager.calls.contains(.requestImageData))
    }
    
    func test_handleSearchingFetchedList_callsPresenterOnReceivedSearchedList() {
        let moviesResult = MovieFakes().movieResult
        
        sut.handleSearchingFetchedList(moviesResult)
        
        XCTAssertEqual(presenter.calls, [.onReceivedSearchedList])
    }
    
    func test_handleServiceError_callsOnreceivedWithError() {
        let serviceError = ServiceError.parsingData
        
        sut.handleService(error: serviceError)
        
        XCTAssertEqual(presenter.calls, [.onReceivedError])
    }
}
