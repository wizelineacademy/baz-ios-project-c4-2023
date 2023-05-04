//
//  SearchViewControllerTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 03/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

final class SearchViewControllerTests: XCTestCase {
    
    var sut: SearchTableViewController!
    var viewModel: SearchViewModelMock!

    override func tearDown() {
        sut = nil
        viewModel = nil
        super.tearDown()
    }

    func setSutWithLocalData(media: [MediaItem]? = nil) {
        let localData = SearchLocalDataMock()
        localData.items = media
        viewModel = SearchViewModelMock(remoteData: SearchRemoteDataMock(), localData: localData)
        sut = SearchTableViewController(viewModel: viewModel)
        sut.dispatchService = DispatchMock()
    }
    
    func setSutWithRemoteData(media: [MediaDataObject]? = nil) {
        let remote = SearchRemoteDataMock()
        remote.mediaObject = media
        sut = SearchTableViewController(viewModel: SearchViewModelMock(remoteData: remote, localData: SearchLocalDataMock()))
    }
    
    func test_titleWasSet() {
        sut = SearchTableViewController(viewModel: SearchViewModelMock(remoteData: SearchRemoteDataMock(), localData: SearchLocalDataMock()))
        
        sut.loadView()
        
        XCTAssertEqual(sut.title, "Search")
    }
    
    func test_searchBarWasSet() {
        sut = SearchTableViewController(viewModel: SearchViewModelMock(remoteData: SearchRemoteDataMock(), localData: SearchLocalDataMock()))
        
        sut.loadView()
        
        XCTAssertNotNil(sut.searchController.searchBar.placeholder = "Search moves, tv series, people...")
    }
    
    func test_initialDataLoaded() {
        let media = [MediaItem(mediaType: .movie), MediaItem(mediaType: .tv), MediaItem(mediaType: .person)]
        setSutWithLocalData(media: media)
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 4
        var dispatch = DispatchMock()
        dispatch.expectation = expectation
        sut.dispatchService = dispatch
        
        sut.loadViewIfNeeded()
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(sut.dataSource?.snapshot().numberOfItems, media.count)
    }

}

class SearchViewModelMock: SearchViewModel {

}

