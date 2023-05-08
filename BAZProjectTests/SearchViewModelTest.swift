//
//  SearchViewModelTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 21/04/23.
//

import XCTest
@testable import BAZProject

final class SearchViewModelTest: XCTestCase {

    private var sut: SearchViewModel!
    
    override func setUp() {
        super.setUp()

        sut = SearchViewModel()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testSearch_checkNumberOfSections() {
        let resultExpected = 1
        
        XCTAssertEqual(sut.numberOfSections(), resultExpected)
    }
    
    func testSearch_whenReadFromAPI_checkNumberOfMovies() {
        let resultExpected = 20
        
        let expectation = XCTestExpectation(description: "Obteniendo resultados de la busqueda")
        
        sut.search(query: "Piratas") { [weak self] in
            XCTAssertEqual(self?.sut.numberOfRowsInSection(0), resultExpected)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 5)
    }
    
    func testSearch_movieAtFirstIndexWithOutLoadMovies_checkNil() {
        let result = sut.movieAtIndex(0)

        XCTAssertNil(result)
    }
}
