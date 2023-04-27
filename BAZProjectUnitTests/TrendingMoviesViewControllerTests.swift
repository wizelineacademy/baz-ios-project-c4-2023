//
//  TrendingMoviesViewControllerTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 30/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesViewControllerTests: XCTestCase {
    
    private func configureSut(with movies: [MediaDataObject] = []) -> TrendingMoviesViewController {
        let viewModel = TrendingMoviesViewModelMock(movies: movies, remoteData: TrendingRemoteDataMock())
        let sut = TrendingMoviesViewController(viewModel: viewModel)
        return sut
    }

    func test_NumberOfRowsInSection_ShouldBeThree() {
        //Given
        let movies = [MediaDataObject(title: "title1"), MediaDataObject(title: "title2"), MediaDataObject(title: "title3")]
        let sut = configureSut(with: movies)
        
        //When
        sut.loadViewIfNeeded()
        let rows = sut.numberOfRows()
        
        //Then
        XCTAssertEqual(rows, movies.count)
    }
    
    func test_NumberOfRowsInSection_ShouldBeZero() {
        //Given
        let movies = [MediaDataObject]()
        let sut = configureSut(with: movies)
        
        //When
        sut.loadViewIfNeeded()
        let rows = sut.numberOfRows()
        
        //Then
        XCTAssertEqual(rows, movies.count)
    }
    
}

extension TrendingMoviesViewController {
    func numberOfRows() -> Int {
        return collectionView(collectionView, numberOfItemsInSection: 1)
    }
}
