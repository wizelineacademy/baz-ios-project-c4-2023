//
//  FavoritesViewControllerTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 07/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

final class FavoritesViewControllerTest: XCTestCase {
    
    var sut: FavoritesViewController!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "FavoritesVC") as! FavoritesViewController
        sut.setupViewModel(MovieListViewModel(.favorites))
        sut.loadViewIfNeeded()
        sut.reloadData()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testTitleWhenStartsIsEqualToViewModel() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationItem.title, "Favorite Movies")
    }
    
    func testNavigationBarDoesNotHaveLargeTitle() {
        let nv = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationController?.navigationBar.prefersLargeTitles, false)
    }
}

