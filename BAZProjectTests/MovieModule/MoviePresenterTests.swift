//
//  MoviePresenterTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 25/04/23.
//

import XCTest

@testable import BAZProject

final class MoviePresenterTests: XCTestCase {
    
    var sut: (MoviePresenterProtocol & MovieInteractorOutputProtocol)?
    var interactorMock: MovieInteractorMock!
    var viewMock: MovieViewMock!
    
    override func setUp() {
        super.setUp()
        sut = MoviePresenter()
        viewMock = MovieViewMock()
        interactorMock = MovieInteractorMock()
        sut?.view = viewMock
        sut?.interactor = interactorMock
    }

    override func tearDown() {
       super.tearDown()
        sut = nil
        interactorMock = nil
    }
    
    // cmd + option + { Arriba
    // cmd + option + } abajo
    // cmd + shift + o spotlight
    // cmd + shift + j abrir ubicación archivo
    func testNotifyViewLoaded() {
        // Given
        let result: [MovieMainInteractorMockCalls] = [.fetchMovies]
        
        // When
        sut?.notifyViewLoaded()
        
        // Then
        XCTAssertEqual(interactorMock.calls, result)
    }
    
    func testMoviesFetched() {
        // Given
        let expectation: XCTestExpectation = XCTestExpectation(description: "reloadData was called")
        viewMock.expectation = expectation
        
        // When
        sut?.moviesFetched(movies: [Movie]())
        
        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(sut?.movies?.count, 0)
        XCTAssertTrue(viewMock.reloadDataWasCalled)
    }

}


