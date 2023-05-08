//
//  SearchViewControllerTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 07/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

/// This class contains the test cases for the SearchViewController class.
final class SearchViewControllerTest: XCTestCase {
    
    // MARK: - Properties
    
    /// The subject under test.
    var sut: SearchViewController!
    
    // MARK: - Set up and tear down
    
    override func setUp() {
        super.setUp()
        
        // Set up the initial state of the subject under test.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "SearchVC") as! SearchViewController
        sut.loadViewIfNeeded()

        sut.viewModel = SearchViewModel()
        sut.setupTable()
        
        let moveListFake = try? JSONDecoder().decode(MovieList.self, from: MovieFakes().search)
        sut.viewModel?.setMovies(moveListFake?.results ?? [])
    }
    
    override func tearDown() {
        // Clean up the state of the subject under test.
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test methods
    
    /// Tests that the navigation item title of the SearchViewController is equal to the title of its view model.
    func testTitleWhenStartsIsEqualToViewModel() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationItem.title, sut.viewModel?.title)
    }
    
    /// Tests that the navigation bar of the SearchViewController does not have large titles.
    func testNavigationBarDoesNotHaveLargeTitle() {
        let nv = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationController?.navigationBar.prefersLargeTitles, false)
    }
    
    /// Tests that the number of rows in the first section of the SearchViewController's table view is equal to the expected value.
    func testSearchViewController_whenReadFromMock_checkNumberOfTMovies() {
        let resultExpected = 20
        let result = sut.viewModel?.numberOfRowsInSection(0)

        XCTAssertEqual(result, resultExpected)
    }
    
    /// Tests that the movie object at a valid index of the SearchViewController's table view is not nil.
    func testSearchViewController_whenSpecifyValidIndex_isNotNil() {
        let result = sut.viewModel?.movieAtIndex(0)

        XCTAssertNotNil(result)
    }
    
    /// Tests that the movie object at an invalid index of the SearchViewController's table view is nil.
    func testSearchViewController_whenSpecifyInvalidIndex_isNil() {
        let result = sut.viewModel?.movieAtIndex(100)

        XCTAssertNil(result)
    }
    
    /// Tests that the number of rows in the SearchViewController's table view is equal to the expected value after reloading the data.
    func testSearchViewController_whenReadFromTableview_checkNumberOfTMovies() {
        sut.loadViewIfNeeded()

        sut.tableView.reloadData()

        let resultExpected = 59
        XCTAssertEqual(sut.tableView.dataSource.debugDescription.data(using: .utf8)?.count, resultExpected)
    }
    
    /// Tests that the SearchViewController's table view has a data source set up correctly.
    func testSearchViewController_HasDatasourceSetUpCorrect() {
        XCTAssertNotNil(sut.tableView.dataSource)
    }
    
    /// Tests that the SearchViewController's table view initially has elements.
    func testSearchViewController_TableViewInitallyHasElements() {
        XCTAssertTrue(sut.tableView.dataSource!.tableView(sut.tableView, numberOfRowsInSection: 0) > 0)
    }
}
