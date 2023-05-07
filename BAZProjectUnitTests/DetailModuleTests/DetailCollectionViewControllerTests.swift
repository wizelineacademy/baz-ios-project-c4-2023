//
//  DetailCollectionViewControllerTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 06/05/23.
//

import XCTest
@testable import BAZProject

final class DetailCollectionViewControllerTests: XCTestCase {

    var sut: DetailCollectionViewController!
    var remoteData: DetailRemoteDataMock!
    var viewModel: DetailViewModel!
    override func setUp() {
        super.setUp()
        remoteData = DetailRemoteDataMock()
    }
    
    override func tearDown() {
        sut = nil
        remoteData = nil
        super.tearDown()
    }
    
    func setViewController(mediaItem: MediaItem) {
        viewModel = DetailViewModel(remoteData: remoteData, item: mediaItem)
        let vc = DetailCollectionViewController(viewModel: viewModel)
        sut = UINavigationController(rootViewController: vc).topViewController as? DetailCollectionViewController
    }
    
    func test_NavigationTitle_ShouldBeEqualToMediaItemTitle() {
        let title = "High School Musical"
        let mediaItem = MediaItem(title: title)
        setViewController(mediaItem: mediaItem)
        
        sut.loadViewIfNeeded()
        
        let navBarTitle = sut.navigationController?.navigationItem.title
        
        XCTAssertEqual(navBarTitle, title)
    }
    
    func test_bindSnapshot() {
        setViewController(mediaItem: MediaItem())
        let expectation = XCTestExpectation()
        sut.dispatchService = DispatchMock(expectation: expectation)
        
        sut.loadViewIfNeeded()
        sut.bindSnapshot()
        wait(for: [expectation], timeout: 0.5)
        let snapshot = sut.dataSource?.snapshot()
        
        XCTAssertNotNil(snapshot)
    }
    
}
