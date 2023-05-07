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
        
        remoteData.mediaItems = mediaItems
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
        let dataObjects = [MediaDataObject(mediaType: "movie"), MediaDataObject(mediaType: "tv"), MediaDataObject(mediaType: "person")]
        let dctObject = [MediaType.movie: [MediaItem(mediaType: .movie)], MediaType.tv: [MediaItem(mediaType: .tv)], MediaType.person: [MediaItem(mediaType: .person)]]
        
        let dctOutput = sut.formatMediaDataObject(dataObjects)
        
        XCTAssertEqual(dctObject, dctOutput)
    }
    
    func test_getSectionTitles() {
        let mediaItems = [MediaDataObject(title: "title1", mediaType: "movie"), MediaDataObject(title: "title2", mediaType: "tv"), MediaDataObject(title: "title3", mediaType: "person")]
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        remoteData.mediaItems = mediaItems
        sut.loadData()
        sut.bindSnapshot { _ in
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        let section1 = sut.getGroupTitle(for: MediaType.movie.order)
        let section2 = sut.getGroupTitle(for: MediaType.tv.order)
        let section3 = sut.getGroupTitle(for: MediaType.person.order)
        
        XCTAssertEqual(section1, MediaType.movie.groupTitle)
        XCTAssertEqual(section2, MediaType.tv.groupTitle)
        XCTAssertEqual(section3, MediaType.person.groupTitle)
    }
    
}
