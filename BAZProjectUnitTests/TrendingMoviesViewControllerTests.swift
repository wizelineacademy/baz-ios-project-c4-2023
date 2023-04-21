//
//  TrendingMoviesViewControllerTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 30/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesViewControllerTests: XCTestCase {

    func test_NumberOfRowsInSection_ShouldBeThree() {
        //Given
        let movies = [Movie(title: "title1"), Movie(title: "title2"), Movie(title: "title3")]
        let viewModel = TrendingMoviesViewModelMock(movies: movies, remoteData: TrendingRemoteDataMock())
        let sut = TrendingMoviesViewController(viewModel: viewModel)
        
        //When
        sut.loadViewIfNeeded()
        let rows = sut.tableView(sut.moviesTableView, numberOfRowsInSection: 0)
        
        //Then
        XCTAssertEqual(rows, movies.count)
    }
    
    func test_NumberOfRowsInSection_ShouldBeZero() {
        //Given
        let movies = [Movie]()
        let viewModel = TrendingMoviesViewModelMock(movies: movies, remoteData: TrendingRemoteDataMock())
        let sut = TrendingMoviesViewController(viewModel: viewModel)
        
        //When
        sut.loadViewIfNeeded()
        let rows = sut.tableView(sut.moviesTableView, numberOfRowsInSection: 0)
        
        //Then
        XCTAssertEqual(rows, movies.count)
    }
    
}
