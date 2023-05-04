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

    func setSutWithLocalData(media: [MediaItem]? = nil, expectation: XCTestExpectation) {
        let localData = SearchLocalDataMock()
        localData.items = media
        viewModel = SearchViewModelMock(remoteData: SearchRemoteDataMock(), localData: localData)
        sut = SearchTableViewController(viewModel: viewModel)
        setSutExpectation(expectation: expectation)
    }
    
    func setSutWithRemoteData(media: [MediaDataObject]? = nil, expectation: XCTestExpectation) {
        let remote = SearchRemoteDataMock()
        remote.mediaObject = media
        sut = SearchTableViewController(viewModel: SearchViewModelMock(remoteData: remote, localData: SearchLocalDataMock()))
        setSutExpectation(expectation: expectation)
    }
    
    func setSutExpectation(expectation: XCTestExpectation) {
        var dispatch = DispatchMock()
        dispatch.expectation = expectation
        sut.dispatchService = dispatch
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
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 3
        setSutWithLocalData(media: media, expectation: expectation)
        
        sut.loadViewIfNeeded()
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(sut.dataSource?.snapshot().numberOfItems, media.count)
    }
    
    func test_searchData_ShouldHaveThreeElements() {
        let media = [MediaDataObject(mediaType: "tv"), MediaDataObject(mediaType: "person")]
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 6
        setSutWithRemoteData(media: media, expectation: expectation)
        
        sut.searchController.searchBar.text = "Harry"
        sut.loadViewIfNeeded()
        sut.updateSearchResults(for: sut.searchController)
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(sut.dataSource?.snapshot().numberOfItems, media.count)
    }
    
    func test_searchData_ShouldNotSearchWithEmptyString() {
        let media = [MediaDataObject(mediaType: "tv"), MediaDataObject(mediaType: "person")]
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 1
        setSutWithRemoteData(media: media, expectation: expectation)
        
        sut.loadViewIfNeeded()
        sut.updateSearchResults(for: sut.searchController)
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(sut.dataSource?.snapshot().numberOfItems, 0)
    }

}

class SearchViewModelMock: SearchViewModel {

}

