//
//  MovieDetailViewControllerTests.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 03/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

final class MovieDetailViewControllerTests: XCTestCase {
    
    
    var sut: MovieDetailViewController!
    let vm = MovieViewModel(Movie(id: 238, title: "The Godfather", poster_path: "https://image.tmdb.org/t/p/w500/3bhkrj58Vtu7enYsRolD1fZdja1.jpg", overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.", release_date: "1972-03-14", popularity: 102.666, vote_average: 8.7))
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
        sut.movieVM = vm
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testTitleWhenStartsIsEqualToViewModel() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationItem.title, vm.title)
    }
    
    func testNavigationBarDoesNotHaveLargeTitle() {
        let nv = UINavigationController(rootViewController: sut)
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.navigationController?.navigationBar.prefersLargeTitles, true)
    }
    
    func testLabelTitleHasSameTitleAsViewModel() {
        sut.loadViewIfNeeded()
        XCTAssertEqual(sut.lblTitle.text, vm.title)
    }
    
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
