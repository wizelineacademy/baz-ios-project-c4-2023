//
//  SearchViewControllerTests.swift
//  BAZProjectTests
//
//  Created by Manuel S on 21/04/23.
//

import XCTest
@testable import BAZProject

final class SearchViewControllerTests: XCTestCase {

    func test_rowsNotZero() {
        let sut = UIStoryboard(name: "SearchView", bundle: nil).instantiateViewController(withIdentifier: "Main") as! SearchView
        let viewModel = SearchViewModelMock(service: ServiceAPI(session: SessionMock()))
        sut.viewModel = viewModel
        let movies = [Movie(), Movie()]
        viewModel.movies = movies
        
        sut.loadViewIfNeeded()
        let rows = sut.tableView.numberOfRows(inSection: 0)
        
        XCTAssertEqual(movies.count, rows)
    }

}
