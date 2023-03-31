//
//  TrendingMoviesViewControllerTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 30/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesViewControllerTests: XCTestCase {
    
    var sut: TrendingMoviesViewController!
    var viewModel: TrendingMoviesViewModelMock!

    override func setUp() {
        super.setUp()
        viewModel = TrendingMoviesViewModelMock()
        sut = TrendingMoviesViewController.getInstance(with: viewModel)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func test_NumberOfRowsInSection_ShouldBeThree() {
        //Given
        let movies = [Movie(title: "title1"), Movie(title: "title2"), Movie(title: "title3")]
        
        //When
        viewModel.movies = movies
        sut.viewDidLoad()
        let rows = sut.tableView(sut.moviesTableView, numberOfRowsInSection: 0)
        
        //Then
        XCTAssertEqual(rows, movies.count)
    }
    
    func test_NumberOfRowsInSection_ShouldBeZero() {
        //Given
        let movies = [Movie]()
        
        //When
        viewModel.movies = movies
        sut.viewDidLoad()
        let rows = sut.tableView(sut.moviesTableView, numberOfRowsInSection: 0)
        
        //Then
        XCTAssertEqual(rows, movies.count)
    }
    
}
