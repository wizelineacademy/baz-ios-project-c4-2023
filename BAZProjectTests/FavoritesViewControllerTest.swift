//
//  FavoritesViewControllerTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 07/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

/// This is a test class for the FavoritesViewController. It is responsible for testing the behavior of the FavoritesViewController in various scenarios.
final class FavoritesViewControllerTest: XCTestCase {
    
    // MARK: - Properties
    
    /// The subject under test.
    var sut: FavoritesViewController!
    
    // MARK: - Set up and tear down
    
    override func setUp() {
        super.setUp()
        
        // Set up the initial state of the subject under test.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoritesViewController
        sut.setupViewModel(MovieListViewModel(.favorites))
        sut.loadViewIfNeeded()
        sut.reloadData()
    }
    
    override func tearDown() {
        // Clean up the state of the subject under test.
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test methods
    
    /// Test to ensure that the navigation item title of FavoritesViewController is set to "Favorite Movies" upon load.
    func testTitleWhenStartsIsEqualToViewModel() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationItem.title, "Favorite Movies")
    }
    
    /// Test to ensure that the navigation bar of FavoritesViewController does not have large title upon load.
    func testNavigationBarDoesNotHaveLargeTitle() {
        let nv = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationController?.navigationBar.prefersLargeTitles, false)
    }
}
