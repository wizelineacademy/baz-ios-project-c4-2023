//
//  SearchViewTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 18/04/23.
//

import Foundation
import BAZProject
import XCTest

final class SearchViewTest: XCTestCase {
    
    var sut: SearchViewController?
    
    override func setUp() {
        super.setUp()
        sut = SearchViewController(nibName: "SearchViewController", bundle: Bundle(for: SearchViewController.self))
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testEmptyTable() {
        //Given
        let iRowsExpected = 0
        //When
        let iRowsInTable = sut?.tblResults.numberOfRows(inSection: 0)
        //Then
        XCTAssertEqual(iRowsExpected, iRowsInTable)
    }
    
    func testTableViewIsReloaded() {
        //Given
        let arrCells = [Movie(id: 1, title: "Título de prueba", poster_path: "Algún path", overview: "Alguna descripción"), Movie(id: 2, title: "Otro título de prueba", poster_path: "Algún otro path", overview: "Alguna otra descripción")]
        //When
        sut?.showResults(in: arrCells)
        //Then
        let iTotalRows = sut?.tblResults.numberOfRows(inSection: 0)
        XCTAssertEqual(arrCells.count, iTotalRows)
        
    }
    
    func testErrorIsShown() {
        //Given
        let strErrorTest = "Test error"
        //When
        sut?.placeInLabel(message: strErrorTest)
        //Then
        XCTAssertEqual(strErrorTest, sut?.lblErrorMessage.text)
    }
    
}


