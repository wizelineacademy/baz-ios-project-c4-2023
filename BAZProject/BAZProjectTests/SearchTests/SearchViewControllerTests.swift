//
//  SearchViewControllerTests.swift
//  BAZProjectTests
//
//  Created by Manuel S on 21/04/23.
//

import XCTest
@testable import BAZProject

final class SearchViewControllerTests: XCTestCase {

    var sut: SearchViewController?

    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "SearchView", bundle: nil).instantiateViewController(withIdentifier: "Main") as? SearchViewController
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func test_rowsNotZero() {
        //Given
        let viewModel = SearchViewModelMock(service: ServiceAPI(session: SessionMock()))
        sut?.viewModel = viewModel
        let movies = [Movie(), Movie()]
        viewModel.movies = movies
        //Then
        sut?.loadViewIfNeeded()
        let rows = sut!.tableView.numberOfRows(inSection: 0)
        //When
        XCTAssertNotNil(rows)
    }
    
    func test_IsbuttonCancelShows() {
        sut?.loadViewIfNeeded()
        //When
        XCTAssertTrue(sut!.searchBar.showsCancelButton)
    }
    
    func test_TableSelected() {
        sut?.loadViewIfNeeded()
        let button = sut!.searchBar.isSearchResultsButtonSelected
        //When
        XCTAssertFalse(button)
    }
    
    func testSearchView_TitleIsEqualToViewModel() {
        sut?.loadViewIfNeeded()
        //When
        XCTAssertEqual(sut?.navigationItem.title, "Buscar")
    }
    
    func testSearchView_PlaceHolderIsEqualToView() {
        //Given
        sut?.loadViewIfNeeded()
        //Then
        let placeH = sut?.searchBar.placeholder
        //When
        XCTAssertEqual(placeH, "Busca tu pelicula")
    }
    
    func testSearchView_ButtonClicked() {
        //Given
        guard let searchBar = sut?.searchBar else { return }
        sut?.loadViewIfNeeded()
        //Then
        sut?.searchBarCancelButtonClicked(searchBar)
        //When
        XCTAssertEqual(sut?.searchBar.text, "")
    }
    
    func testSearchView_ButtonTextNotnil() {
        //Given
        guard let searchBar = sut?.searchBar else { return }
        sut?.loadViewIfNeeded()
        //Then
        sut?.searchBarSearchButtonClicked(searchBar)
        //When
        XCTAssertNotNil(searchBar.text)
    }
    
    func testSearchView_TypeSearch_IsActor() {
        //Given
        guard let searchBar = sut?.searchBar else { return }
        sut?.loadViewIfNeeded()
        //Then
        let index = sut?.searchBar.selectedScopeButtonIndex
        
        //When
        XCTAssertEqual(index, 1)
    }
}
