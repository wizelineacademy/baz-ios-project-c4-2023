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
    
    private func configureSut(with media: [MediaDataObject] = [], expectation: XCTestExpectation? = nil) {
        let remoteData = TrendingMediaRemoteDataMock()
        remoteData.mediaItems = media
        var dispatchService = DispatchMock()
        dispatchService.expectation = expectation
        viewModel = TrendingMediaViewModelMock(remoteData: remoteData)
        sut = TrendingMediaViewController(viewModel: viewModel)
        sut.dispatchService = dispatchService
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }

    func test_snapshotAppliedCorrectly_NumberOfItemsInSectionsShouldBeOneAndThree() {
        //Given
        var items = [MediaDataObject]()
        let movies = [MediaDataObject(title: "title1", mediaType: "movie"), MediaDataObject(title: "title2", mediaType: "movie"), MediaDataObject(title: "title3", mediaType: "movie")]
        let tv = [MediaDataObject(title: "title4", mediaType: "tv")]
        items.append(contentsOf: tv)
        items.append(contentsOf: movies)
        configureSut(with: items)
        let exepectation = XCTestExpectation()
        exepectation.expectedFulfillmentCount = 2
        var dispatchService = DispatchMock()
        dispatchService.expectation = exepectation
        sut.dispatchService = dispatchService
        
        //When
        sut.loadViewIfNeeded()
        wait(for: [exepectation], timeout: 0.1)
        let movieItems = sut.dataSource?.snapshot(for: .movie).items.count
        let tvItems = sut.dataSource?.snapshot(for: .tv).items.count
        
        //Then
        XCTAssertEqual(movieItems, movies.count)
        XCTAssertEqual(tvItems, tv.count)
    }
    
    func test_NumberOfRowsInSection_NotReachingBindingClosure() {
        //Given
        let movies = [MediaDataObject(title: "title1", mediaType: "movie"), MediaDataObject(title: "title2", mediaType: "movie"), MediaDataObject(title: "title3", mediaType: "movie")]
        let exepectation = XCTestExpectation()
        configureSut(with: movies, expectation: exepectation)
        //When
        sut.loadViewIfNeeded()
        wait(for: [exepectation], timeout: 0.5)
        let actualItems = sut.dataSource?.snapshot().numberOfItems
        
        //Then
        XCTAssertEqual(movies.count, actualItems)
    }
}

class TrendingMediaViewModelMock: TrendingMediaViewModel {}
