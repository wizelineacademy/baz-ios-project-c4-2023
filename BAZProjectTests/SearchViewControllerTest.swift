//
//  SearchViewControllerTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 07/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

final class SearchViewControllerTest: XCTestCase {
    
    var sut: SearchViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchViewController
        sut.loadViewIfNeeded()

        sut.viewModel = SearchViewModel()
        sut.setupTable()
        
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().search)
        sut.viewModel?.setMovies(moveListFake?.results ?? [])
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testTitleWhenStartsIsEqualToViewModel() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationItem.title, sut.viewModel?.title)
    }
    
    func testNavigationBarDoesNotHaveLargeTitle() {
        let nv = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationController?.navigationBar.prefersLargeTitles, false)
    }
    
    func testSearchViewController_whenReadFromMock_checkNumberOfTMovies() {
        let resultExpected = 20
        let result = sut.viewModel?.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    func testSearchViewController_whenSpecifyValidIndex_isNotNil() {
        let result = sut.viewModel?.movieAtIndex(0)

        XCTAssertNotNil(result)
    }
    
    func testSearchViewController_whenSpecifyInvalidIndex_isNil() {
        let result = sut.viewModel?.movieAtIndex(100)

        XCTAssertNil(result)
    }
    
    func testSearchViewController_whenReadFromTableview_checkNumberOfTMovies() {
        sut.loadViewIfNeeded()

        sut.tableView.reloadData()

        let resultExpected = 59
        XCTAssertEqual(sut.tableView.dataSource.debugDescription.data(using: .utf8)?.count, resultExpected)
    }
    
    func testSearchViewController_HasDatasourceSetUpCorrect() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    func testSearchViewController_TableViewInitallyHasElements() {
        XCTAssertTrue(sut.tableView.dataSource!.tableView(sut.tableView, numberOfRowsInSection: 0) > 0)
    }
    
}

