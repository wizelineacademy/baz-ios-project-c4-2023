//
//  SearcPresenterTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import XCTest

@testable import BAZProject

final class SearcPresenterTests: XCTestCase {
    
    var sut: (SearchPresenterProtocol & SearchInteractorOutputProtocol)?
    var interactorMock: SearchInteractorMock!
    var viewMock: SearchViewMock!
    
    override func setUp() {
        super.setUp()
        sut = SearchPresenter()
        viewMock = SearchViewMock()
        interactorMock = SearchInteractorMock()
        sut?.view = viewMock
        sut?.interactor = interactorMock
    }

    override func tearDown() {
       super.tearDown()
        sut = nil
        interactorMock = nil
    }
    
    func testMoviesFetched() {
        // Given
        let expectation: XCTestExpectation = XCTestExpectation(description: "reloadData was called")
        viewMock.expectation = expectation
        
        // When
        sut?.searchResultsFecthed(searchResults: [SearchResult]())
        
        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(sut?.searchResults?.count, 0)
        XCTAssertTrue(viewMock.reloadDataWasCalled)
    }
    
    func testSearchMovies() {
        XCTAssert(((sut?.searchMovies(with: "Mario")) != nil))
    }
}
