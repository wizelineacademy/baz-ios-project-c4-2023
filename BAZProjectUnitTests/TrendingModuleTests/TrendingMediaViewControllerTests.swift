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
    var remote: TrendingMediaRemoteDataMock!
    
    private func configureSut(expectation: XCTestExpectation? = nil) {
        remote = TrendingMediaRemoteDataMock()
        var dispatchService = DispatchMock()
        dispatchService.expectation = expectation
        viewModel = TrendingMediaViewModelMock(remoteData: remote)
        sut = TrendingMediaViewController(viewModel: viewModel)
        sut.dispatchService = dispatchService
    }
    
    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }

    func test_snapshotAppliedCorrectly_NumberOfTotalItemsIs5() {
        //Given
        let section1 = [MediaDataObject(title: "title1", mediaType: "movie")]
        let section2 = [MediaDataObject(title: "title2", mediaType: "movie")]
        let section3 = [MediaDataObject(title: "title3", mediaType: "movie")]
        let section4 = [MediaDataObject(title: "title4", mediaType: "movie")]
        let section5 = [MediaDataObject(title: "title5", mediaType: "movie")]
        let exepectation = XCTestExpectation()
        exepectation.expectedFulfillmentCount = 1
        configureSut(expectation: exepectation)
        remote.trending = section1
        remote.popular = section2
        remote.toprated = section3
        remote.nowplaying = section4
        remote.upcoming = section5
        
        //When
        sut.loadViewIfNeeded()
        wait(for: [exepectation], timeout: 0.5)
        let trending = sut.dataSource?.snapshot(for: .trending).items.count
        let upcoming = sut.dataSource?.snapshot(for: .upcoming).items.count
        let nowPlaying = sut.dataSource?.snapshot(for: .nowPlaying).items.count
        let topRated = sut.dataSource?.snapshot(for: .topRated).items.count
        let popular = sut.dataSource?.snapshot(for: .popular).items.count
        let overall = sut.dataSource?.snapshot().numberOfItems
        
        //Then
        XCTAssertEqual(section1.count, trending)
        XCTAssertEqual(section2.count, popular)
        XCTAssertEqual(section3.count, topRated)
        XCTAssertEqual(section4.count, nowPlaying)
        XCTAssertEqual(section5.count, upcoming)
        XCTAssertEqual(section1.count + section2.count + section3.count + section4.count + section5.count, overall)
    }
    
    func test_NumberOfRowsInSection_NotReachingBindingClosure() {
        //Given
        let movies = [MediaDataObject(title: "title1", mediaType: "movie")]
        let exepectation = XCTestExpectation()
        configureSut(expectation: exepectation)
        remote.trending = movies
        //When
        sut.loadViewIfNeeded()
        wait(for: [exepectation], timeout: 0.5)
        let actualItems = sut.dataSource?.snapshot().numberOfItems
        
        //Then
        XCTAssertEqual(movies.count, actualItems)
    }
}

class TrendingMediaViewModelMock: TrendingMediaViewModel {}
