//
//  TrendingMediaViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingMediaViewModelTests: XCTestCase {
    
    var sut: TrendingMediaViewModel!
    var remoteData: TrendingMediaRemoteDataMock!
    
    override func setUp() {
        super.setUp()
        remoteData = TrendingMediaRemoteDataMock()
        sut = TrendingMediaViewModel(remoteData: remoteData)
    }
    
    override func tearDown() {
        remoteData = nil
        sut = nil
        super.tearDown()
    }
    
    func test_GetMovies_MoviesCountShouldBeThree() {
        let mediaItems = [MediaDataObject(title: "title1", mediaType: "movie"), MediaDataObject(title: "title2", mediaType: "movie"), MediaDataObject(title: "title3", mediaType: "movie")]
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        var actualValue: TrendingMediaViewModel.MediaCollectionSnapShot?
        
        remoteData.trending = mediaItems
        sut.loadData()
        sut.bindSnapshot { snapshot in
            actualValue = snapshot
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(mediaItems.count, actualValue?.numberOfItems)
    }
    
    func test_GetMovies_Error() {
        let error = NSError(domain: "", code: -666)
        let expectation = XCTestExpectation()
        var actualError: Error?
        
        remoteData.error = error
        sut.bindError { (error) in
            actualError = error
            expectation.fulfill()
        }
        sut.loadData()
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertNotNil(actualError)
    }
    
    func test_GetMovies_MoviesCountShouldBeZeroByNilData() {
        let expectation = XCTestExpectation()
        var actualValue: TrendingMediaViewModel.MediaCollectionSnapShot?
        
        sut.bindSnapshot { snapshot in
            actualValue = snapshot
            expectation.fulfill()
        }
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertEqual(0, actualValue?.numberOfItems)
    }

    func test_getFormattedObjects() {
        let dataObjects = [MediaDataObject(id: 1, mediaType: "movie"), MediaDataObject(id: 2, mediaType: "tv"), MediaDataObject(id: 3, mediaType: "person")]
        let dctObject = [TrendingMediaSection.trending: [MediaItem(id: 1, mediaType: .movie), MediaItem(id: 2, mediaType: .tv), MediaItem(id: 3, mediaType: .person)]]
        
        let dctOutput = sut.formatMediaDataObject(trending: dataObjects, popular: nil, upcoming: nil, topRated: nil, nowPlaying: nil)
        
        XCTAssertEqual(dctObject.count, dctOutput.count)
    }
    
    func test_getSectionTitles() {
        let mediaItems1 = [MediaDataObject(title: "title1", mediaType: "movie")]
        let mediaItems2 = [MediaDataObject(title: "title2", mediaType: "movie")]
        let mediaItems3 = [MediaDataObject(title: "title3", mediaType: "movie")]
        let mediaItems4 = [MediaDataObject(title: "title4", mediaType: "movie")]
        let mediaItems5 = [MediaDataObject(title: "title5", mediaType: "movie")]
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        remoteData.trending = mediaItems1
        remoteData.upcoming = mediaItems2
        remoteData.popular = mediaItems3
        remoteData.toprated = mediaItems4
        remoteData.nowplaying = mediaItems5
        
        sut.loadData()
        sut.bindSnapshot { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        let section1 = sut.getGroupTitle(for: TrendingMediaSection.trending.rawValue)
        let section2 = sut.getGroupTitle(for: TrendingMediaSection.popular.rawValue)
        let section3 = sut.getGroupTitle(for: TrendingMediaSection.nowPlaying.rawValue)
        let section4 = sut.getGroupTitle(for: TrendingMediaSection.upcoming.rawValue)
        let section5 = sut.getGroupTitle(for: TrendingMediaSection.topRated.rawValue)
        
        XCTAssertEqual(section1, TrendingMediaSection.trending.title)
        XCTAssertEqual(section2, TrendingMediaSection.popular.title)
        XCTAssertEqual(section3, TrendingMediaSection.nowPlaying.title)
        XCTAssertEqual(section4, TrendingMediaSection.upcoming.title)
        XCTAssertEqual(section5, TrendingMediaSection.topRated.title)
    }
    
    func test_DetDetailView_NoMediaShouldReturnNil() {
        let view = sut.getDetailView(for: nil)
        
        XCTAssertNil(view)
    }
    
    func test_DetDetailView_NoMediaTypeInItemShouldReturnNil() {
        let media = MediaItem(id: 12)
        
        let view = sut.getDetailView(for: media)
        
        XCTAssertNil(view)
    }
    
    func test_DetDetailView_NoIdInItemShouldReturnNil() {
        let media = MediaItem(mediaType: .movie)
        
        let view = sut.getDetailView(for: media)
        
        XCTAssertNil(view)
    }
    
    func test_DetDetailView_ShouldReturnDetailViewController() {
        let media = MediaItem(id: 12,  mediaType: .movie)
        
        let view = sut.getDetailView(for: media)
        
        XCTAssertNotNil(view as! DetailCollectionViewController)
    }
    
}
