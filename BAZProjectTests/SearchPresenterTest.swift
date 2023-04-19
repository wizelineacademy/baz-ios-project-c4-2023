//
//  SearchPresenterTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 18/04/23.
//

import Foundation
import XCTest
import BAZProject

final class SearchPresenterTest: XCTestCase {
    var interactor: BAZProject.SearchBusinessLogic?
    private var strMessage: String?
    private var arrCellInfo: [ImageTextTableViewProtocol]?
    private var sut: SearchPresenter?
    
    override func setUp() {
        super.setUp()
        sut = SearchPresenter()
        sut?.view = self
    }
    
    override func tearDown() {
        super.tearDown()
        strMessage = nil
        arrCellInfo = nil
        sut = nil
    }
    
    func testBadInputUserMessage() {
        //Given
        let strErrorExpected = SearchEnumError.invalidString.getString()
        //When
        sut?.search(FailedWith: .invalidString)
        //Then
        XCTAssertEqual(strErrorExpected, strMessage)
    }
    
    func testServiceErrorMessage() {
        //Given
        let strErrorExpected = SearchEnumError.serviceProblem.getString()
        //When
        sut?.search(FailedWith: .serviceProblem)
        //Then
        XCTAssertEqual(strErrorExpected, strMessage)
    }
    
    func testNoDataFound() {
        //Given
        let emptySearch = EmptySearch()
        //When
        sut?.search(FailedWith: .noResultsFound)
        //Then
        let firstElement = arrCellInfo?.first as? EmptySearch
        XCTAssertEqual(emptySearch.strTitle, firstElement?.strTitle)
    }
    
    func testSuccessfullSearchArrCount() {
        //Given
        let arrResponse = [Movie(id: 1, title: "Título de prueba", poster_path: "Algún path", overview: "Alguna descripción"), Movie(id: 2, title: "Otro título de prueba", poster_path: "Algún otro path", overview: "Alguna otra descripción")]
        //When
        sut?.searchDidBrougntResults(in: arrResponse)
        //Then
        XCTAssertEqual(arrResponse.count, arrCellInfo?.count)
    }
    
    func testNoDataFoundCheckText() {
        //Given
        let emptySearch = EmptySearch()
        //When
        sut?.search(FailedWith: .noResultsFound)
        //Then
        let firstElement = arrCellInfo?.first as? EmptySearch
        XCTAssertEqual(emptySearch.strTitle, firstElement?.strTitle)
        XCTAssertEqual(emptySearch.strOverView, firstElement?.strOverView)
        XCTAssertNil(emptySearch.urlConfiguration)
    }
}

extension SearchPresenterTest: SearchDisplayLogic {
    
    func placeInLabel(message strMessage: String) {
        self.strMessage = strMessage
    }
    
    func showResults(in arrCellInfo: [ImageTextTableViewProtocol]) {
        self.arrCellInfo = arrCellInfo
    }
    
    
}
