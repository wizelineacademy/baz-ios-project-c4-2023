//
//  SearchMoviesViewTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 21/04/23.
//

import XCTest
@testable import BAZProject

final class SearchMoviesViewTest: XCTestCase {
    
    var sut         : SearchMoviesView!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = SearchMoviesView()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    // MARK: View - Test
    // Validate backgroundColor of the view
    func test_SearchMoviesView_BackgroundColor() {
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }
    
    // Validate title is nil
    func test_SearchMoviesViewTitleIsNotNil() {
        XCTAssertNil(sut.title)
    }
    
    // validate title is empety
    func test_SearchMoviesViewIsEmptyTitle() {
        //Given
        let expected = ""
        //When
        let titleNav = sut.title ?? ""
        //Then
        XCTAssertEqual(expected, titleNav)
    }
    
    // MARK: Button - Test
    func test_ButtonSearchHasSetDelegate() {
        XCTAssertNotNil(sut.searchBar.delegate)
    }
    
    // MARK: TableView - Test
    func test_TableViewHasSetDatasource() {
        XCTAssertNotNil(sut.tblSearch.dataSource)
    }
    
    func test_TableView_WhenCellRowHasZeroElements(){
        XCTAssertEqual(sut.tblSearch.dataSource?.tableView(sut.tblSearch, numberOfRowsInSection: 0), 0)
    }

}
