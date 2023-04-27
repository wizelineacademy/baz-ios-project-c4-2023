//
//  SearchInteractorTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 17/04/23.
//

import Foundation
import XCTest
import BAZProject

final class SearchInteractorTest: XCTestCase {
    var view: SearchDisplayLogic?
    private var searchError: SearchEnumError?
    private var sut: SearchInteractor?
    private var mockServer: NetworkingProtocol?
    private var arrResults: [ImageTextTableViewProtocol]?
    
    override func setUp() {
        super.setUp()
        sut = SearchInteractor(presenter: self)
    }
    
    override func tearDown() {
        super.tearDown()
        searchError = nil
        sut = nil
        mockServer = nil
    }
    
    func testNilStringThrowsError() {
        //Given
        let errorExpected: SearchEnumError = .invalidString
        //Whern
        sut?.search(withParams: nil)
        //Then
        XCTAssertEqual(errorExpected, searchError)
    }
    
    func testBlankStringThrowsError() {
        //Given
        let errorExpected: SearchEnumError = .invalidString
        //Whern
        sut?.search(withParams: "")
        //Then
        XCTAssertEqual(errorExpected, searchError)
    }
    
    func testWhiteSpaceStringThrowsError() {
        //Given
        let errorExpected: SearchEnumError = .invalidString
        //Whern
        sut?.search(withParams: " ")
        //Then
        XCTAssertEqual(errorExpected, searchError)
    }
    
    func testServiceError() {
        //Given
        let errorExpected: SearchEnumError = .serviceProblem
        mockServer = MockService(configuration: URLConfiguration(path: .noPath), caseToTest: .testError(.badResponse))
        sut?.networkingSearch = mockServer
        //When
        sut?.search(withParams: "Matrix")
        //Then
        XCTAssertEqual(errorExpected, searchError)
    }
    
    func testServiceBringResults() {
        //Given
        let iTotal = 4
        mockServer = MockService(configuration: URLConfiguration(path: .noPath), caseToTest: .testSuccess("responseSearchMock"))
        sut?.networkingSearch = mockServer
        //When
        sut?.search(withParams: "Matrix")
        //Then
        let iSutTotal = arrResults?.count
        XCTAssertEqual(iTotal, iSutTotal)
    }
    
    func testServiceRespondButResultsWereEmpty() {
        //Given
        mockServer = MockService(configuration: URLConfiguration(path: .noPath), caseToTest: .testSuccess("searchVoid"))
        sut?.networkingSearch = mockServer
        //When
        sut?.search(withParams: "jaklfakdja")
        //Then
        XCTAssertTrue(arrResults?.isEmpty ?? false)
        
    }
}

extension SearchInteractorTest: SearchPresentationLogic {
    func search(FailedWith error: SearchEnumError) {
        self.searchError = error
    }
    
    func searchDidBrougntResults(in arrResults: [ImageTextTableViewProtocol]) {
        self.arrResults = arrResults
    }
}
