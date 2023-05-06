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
        let viewModel = SearchViewModelMock(service: ServiceAPI(session: SessionMock()))
        sut?.viewModel = viewModel
        let movies = [Movie(), Movie()]
        viewModel.movies = movies
        
        sut?.loadViewIfNeeded()
        let rows = sut!.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(movies.count, rows)
    }
    
    func test_IsbuttonCancelShows() {
        sut?.loadViewIfNeeded()
        XCTAssertTrue(sut!.searchBar.showsCancelButton)
    }
    
    func test_TableSelected() {
        sut?.loadViewIfNeeded()
        let button = sut!.searchBar.isSearchResultsButtonSelected
        
        XCTAssertFalse(button)
    }
    
    func testSearchView_TitleIsEqualToViewModel() {
        sut?.loadViewIfNeeded()
        XCTAssertEqual(sut?.navigationItem.title, "Buscar")
    }
    
    func testSearchView_PlaceHolderIsEqualToView() {
        sut?.loadViewIfNeeded()
        let placeH = sut?.searchBar.placeholder
        XCTAssertEqual(placeH, "Busca tu pelicula")
    }
    
    func testSearchView_ButtonClicked() {
        guard let searchBar = sut?.searchBar else { return }
        sut?.loadViewIfNeeded()
        sut?.searchBarCancelButtonClicked(searchBar)
        XCTAssertEqual(sut?.searchBar.text, "")
    }
    
    func testSearchView_tonClicked() {
        guard let searchBar = sut?.searchBar else { return }
        sut?.loadViewIfNeeded()
        sut?.searchBarSearchButtonClicked(searchBar)
        XCTAssertNotNil(searchBar.text)
    }
}
