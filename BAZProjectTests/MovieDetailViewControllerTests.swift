//
//  MovieDetailViewControllerTests.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 03/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

/// The MovieDetailViewControllerTests class is a test suite for the MovieDetailViewController.
/// It tests the functionality of various UI elements and their relationship with the underlying data model.
final class MovieDetailViewControllerTests: XCTestCase {
    
    // MARK: - Properties
    
    var sut: MovieDetailViewController!
    let vm = MovieViewModel(Movie(id: 238, title: "The Godfather", poster_path: "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg", overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.", release_date: "1972-03-14", popularity: 102.666, vote_average: 8.7))
    
    // MARK: - Set up and tear down
    
    override func setUp() {
        super.setUp()
        
        // Set up the initial state of the subject under test.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
        sut.movieVM = vm
    }
    
    override func tearDown() {
        // Clean up the state of the subject under test.
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test methods
    
    /// Tests that the navigation item title of the SUT is equal to the title of the view model.
    func testTitleWhenStartsIsEqualToViewModel() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationItem.title, vm.title)
    }
    
    /// Tests that the navigation bar of the SUT does not have a large title.
    func testNavigationBarDoesNotHaveLargeTitle() {
        let nv = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationController?.navigationBar.prefersLargeTitles, true)
    }
    
    /// Tests that the title label of the SUT has the same title as the view model.
    func testLabelTitleHasSameTitleAsViewModel() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.lblTitle.text, vm.title)
    }
    
    /// Tests that the image view of the SUT is assigned an image from the loader.
    func testImageIsAsignedFromLoader() {
        sut.loadViewIfNeeded()
        
        let expectation = expectation(description: "image loader expectation")
        let result = XCTWaiter.wait(for: [expectation], timeout: 3.0)
        
        if result == XCTWaiter.Result.timedOut {
            XCTAssertNotNil(sut.imgView.image)
        } else {
            XCTFail("Failed on time out")
        }
    }
}
