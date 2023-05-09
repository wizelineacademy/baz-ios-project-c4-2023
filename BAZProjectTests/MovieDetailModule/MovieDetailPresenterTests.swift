//
//  MovieDetailPresenterTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailPresenterTests: XCTestCase {
    
    var sut: (MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol)?
    var interactorMock: DetailInteractorMock!
    var viewMock: MovieDetailViewMock!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailPresenter(movieId: 1)
        viewMock = MovieDetailViewMock()
        interactorMock = DetailInteractorMock()
        sut?.view = viewMock
        sut?.interactor = interactorMock
    }

    override func tearDown() {
       super.tearDown()
        sut = nil
        interactorMock = nil
    }
    
    func testNotifyViewLoaded() {
        // Given
        let result: [DetailInteractorMockCalls] = [.fetchMovieDetail]
        
        // When
        sut?.notifyViewLoaded()
        
        // Then
        XCTAssertEqual(interactorMock.detailCalls, result)
    }
    
    func testMoviesFetched() {
        // Given
        let expectation: XCTestExpectation = XCTestExpectation(description: "reloadData was called")
        viewMock.expectation = expectation
        
        // When
        sut?.movieDetailFetched(with: MovieDetail(id: 1, title: "Mario", overview: "Resume", popularity: 9.8, posterPath: "/wybmSmviUXxlBmX44gtpow5Y9TB.jpg", releaseDate: "2023-03-15", status: "movie"))
        
        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(sut?.movieDetail?.id, 1)
        XCTAssertTrue(viewMock.reloadDataWasCalled)
    }

    

}
