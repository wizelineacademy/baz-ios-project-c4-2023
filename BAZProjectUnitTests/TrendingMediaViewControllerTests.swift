//
//  TrendingMediaViewControllerTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 30/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingMediaViewControllerTests: XCTestCase {
    
    var viewModel: TrendingMediaViewModelMock!
    var sut: TrendingMediaViewController!
    
    private func configureSut(with media: [MediaDataObject] = []) {
        viewModel = TrendingMediaViewModelMock(dataObjects: media, remoteData: TrendingMediaRemoteDataMock())
        sut = TrendingMediaViewController(viewModel: viewModel)
    }

    func test_snapshotAppliedCorrectly_NumberOfItemsInSectionsShouldBeOneAndThree() {
        //Given
        var items = [MediaDataObject]()
        let movies = [MediaDataObject(title: "title1", mediaType: "movie"), MediaDataObject(title: "title2", mediaType: "movie"), MediaDataObject(title: "title3", mediaType: "movie")]
        let tv = [MediaDataObject(title: "title4", mediaType: "tv")]
        items.append(contentsOf: tv)
        items.append(contentsOf: movies)
        configureSut(with: items)
        
        //When
        sut.loadViewIfNeeded()
        sut.dataSource?.apply(viewModel.getDataSnapshot())
        let movieItems = sut.dataSource?.snapshot(for: .movie).items.count
        let tvItems = sut.dataSource?.snapshot(for: .tv).items.count
        
        //Then
        XCTAssertEqual(movieItems, movies.count)
        XCTAssertEqual(tvItems, tv.count)
    }
    
    func test_NumberOfRowsInSection_NotReachingBindingClosure() {
        //Given
        let movies = [MediaDataObject(title: "title1", mediaType: "movie"), MediaDataObject(title: "title2", mediaType: "movie"), MediaDataObject(title: "title3", mediaType: "movie")]
        configureSut(with: movies)
        
        //When
        sut.loadViewIfNeeded()
        let actualItems = sut.dataSource?.snapshot().numberOfItems
        
        //Then
        XCTAssertNotEqual(movies.count, actualItems)
    }
    
}
