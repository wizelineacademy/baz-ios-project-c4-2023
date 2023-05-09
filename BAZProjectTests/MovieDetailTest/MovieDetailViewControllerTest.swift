//
//  MovieDetailViewControllerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import XCTest

@testable import BAZProject

final class MovieDetailViewControllerTest: XCTestCase {
    
    var sut: MoviewDetailViewProtocol!

    override func setUp() {
        sut = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_cells_returnId(){
        let castId = "CastCollectionViewCell"
        let movieId = "MovieCollectionViewCell"
        XCTAssertEqual(castId, CastCollectionViewCell.idetifier)
        XCTAssertEqual(movieId, MovieCollectionViewCell.idetifier)
    }
    

}
