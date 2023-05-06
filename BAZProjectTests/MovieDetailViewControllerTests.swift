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
    let vm = MovieViewModel(Movie(id: 234, title: "Prueba", poster_path: "https://image.tmdb.org/t/p/w500/t6HIqrRAclMCA60NsSmeqe9RmNV.jpg", overview: "String", release_date: "ijoie", popularity: 2343.0, vote_average: 2343.0))
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
        sut.movieVM = vm
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
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
}
