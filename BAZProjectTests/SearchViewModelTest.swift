//
//  SearchViewModelTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 21/04/23.
//

import XCTest
@testable import BAZProject

/// This class contains unit tests for the SearchViewModel class.
final class SearchViewModelTest: XCTestCase {
    
    // MARK: - Properties

    /// The subject under test.
    private var sut: SearchViewModel!
    
    // MARK: - Set up and tear down
    
    override func setUp() {
        super.setUp()

        // Set up the initial state of the subject under test.
        sut = SearchViewModel()
    }
    
    override func tearDown() {
        // Clean up the state of the subject under test.
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test methods
    
    func testSearch_checkNumberOfSections() {
        let resultExpected = 1
        
        XCTAssertEqual(sut.numberOfSections(), resultExpected)
    }
    
    /// Tests the number of sections returned by the SearchViewModel.
    func testSearch_whenReadFromAPI_checkNumberOfMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados de la busqueda")
        
        sut.search(query: "Piratas") { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    /// Tests the number of movies returned by the SearchViewModel when read from the API.
    func testSearch_movieAtFirstIndexWithOutLoadMovies_checkNil() {
        let result = sut.movieAtIndex(0)

        XCTAssertNil(result)
    }
}
