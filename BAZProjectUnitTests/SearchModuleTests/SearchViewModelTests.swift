//
//  SearchViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 01/05/23.
//

import XCTest
@testable import BAZProject

final class SearchViewModelTests: XCTestCase {
    
    var sut: SearchViewModel!
    var remoteData: SearchRemoteDataMock!
    var localData: SearchLocalDataMock!

    override func setUp() {
        super.setUp()
        localData = SearchLocalDataMock()
        remoteData = SearchRemoteDataMock()
        sut = SearchViewModel(remoteData: remoteData, localData: localData)
    }

    override func tearDown() {
        localData = nil
        remoteData = nil
        sut = nil
        super.tearDown()
    }

    func test_loadInitialDataFromLocal_SnapshotShouldBeZero() {
        let mediaItems = [MediaItem]()
        localData.items = mediaItems
        let expectation = XCTestExpectation()
        var actualValue: SearchViewModel.MediaSnapshot?
        
        sut.bindSnapshot { snapshot in
            actualValue = snapshot
            expectation.fulfill()
        }
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
        let snapshotItems  = actualValue?.numberOfItems
        
        XCTAssertEqual(mediaItems.count, snapshotItems)
    }
    
    func test_loadInitialDataFromLocal_SnapshotShouldBeZeroByNoMedia() {
        let mediaItems = [MediaItem(id: 123)]
        localData.items = mediaItems
        var actualValue: SearchViewModel.MediaSnapshot?
        let expectation = XCTestExpectation()
        
        sut.bindSnapshot { snapshot in
            actualValue = snapshot
            expectation.fulfill()
        }
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
        let snapshotItems  = actualValue?.numberOfItems
        
        XCTAssertEqual(0, snapshotItems)
    }
    
    func test_loadInitialDataFromLocal_SnapshotShouldBeTwo() {
        let mediaItems = [MediaItem(mediaType: .person), MediaItem(mediaType: .tv)]
        localData.items = mediaItems
        var actualValue: SearchViewModel.MediaSnapshot?
        let expectation = XCTestExpectation()
        
        sut.bindSnapshot { snapshot in
            actualValue = snapshot
            expectation.fulfill()
        }
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
        let snapshotItems  = actualValue?.numberOfItems
        
        XCTAssertEqual(mediaItems.count, snapshotItems)
    }
    
    func test_loadInitialDataFromLocal_ShouldNotUpdateSnapshot() {
        let expectation = XCTestExpectation()
        var actualValue: SearchViewModel.MediaSnapshot?
        
        sut.bindSnapshot { snapshot in
            actualValue = snapshot
            expectation.fulfill()
        }
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
        let snapshotItems  = actualValue?.numberOfItems
        
        XCTAssertEqual(0, snapshotItems)
    }
    
    func test_getCellModel_PersonShouldOnlyHaveNameAndImage() {
        let person = MediaItem(title: "Daniel Radcliffe", mediaType: .person)
        let expectedModel = MediaTableViewCellModel(title: "Daniel Radcliffe", defaultImage: "person.fill", rated: false)
        
        let personModel = sut.getCellModel(for: person)
        
        XCTAssertEqual(expectedModel, personModel)
    }
    
    func test_getCellModel_FootnoteShouldBeDateWhenDateAfterToday() {
        let tomorrowsDate = Calendar.current.date(byAdding: .day, value: 1, to: Date())!
        let tomorrowsStringDate = DateFormatter.common.string(from: tomorrowsDate)
        let person = MediaItem(id: 1, posterPath: "path", title: "title", rating: 1.2, mediaType: .tv, releaseDate: tomorrowsDate)
        let expectedModel = MediaTableViewCellModel(title: "title", subtitle: MediaType.tv.itemTitle, image: "path", defaultImage: MediaType.tv.defaultImage, footNote: tomorrowsStringDate, rated: false)
        
        let personModel = sut.getCellModel(for: person)
        
        XCTAssertEqual(expectedModel, personModel)
    }
    
    func test_getCellModel_FootnoteShouldBeRatingWhenDateBeforeTodayAndDifferentFromAbsoluteZero() {
        let tomorrowsDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let person = MediaItem(id: 1, posterPath: "path", title: "title", rating: 1.2, mediaType: .tv, releaseDate: tomorrowsDate)
        let expectedModel = MediaTableViewCellModel(title: "title", subtitle: MediaType.tv.itemTitle, image: "path", defaultImage: MediaType.tv.defaultImage, footNote: "1.2", rated: true)
        
        let personModel = sut.getCellModel(for: person)
        
        XCTAssertEqual(expectedModel, personModel)
    }
    
    func test_getCellModel_FootnoteShouldBeEmptyWhenDateBeforeTodayAndRatingIsAbsoluteZero() {
        let tomorrowsDate = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let person = MediaItem(id: 1, posterPath: "path", title: "title", rating: 0.0, mediaType: .tv, releaseDate: tomorrowsDate)
        let expectedModel = MediaTableViewCellModel(title: "title", subtitle: MediaType.tv.itemTitle, image: "path", defaultImage: MediaType.tv.defaultImage, footNote: nil, rated: false)
        
        let personModel = sut.getCellModel(for: person)
        
        XCTAssertEqual(expectedModel, personModel)
    }
    
    func test_getSectionTitle_ShouldNotBeNilForIndexZero() {
        let section = 0
        
        let title = sut.getSectionTitle(for: section)
        
        XCTAssertNotNil(title)
    }
    
    func test_getSectionTitle_ShouldBeResultsForOtherIndices() {
        let section = 5
        
        let title = sut.getSectionTitle(for: section)
        
        XCTAssertEqual(title, "Results")
    }
    
    func test_searchMedia_ShouldUpdateSnapshot() {
        let mediaItems = [MediaDataObject(mediaType: "movie"), MediaDataObject(mediaType: "tv")]
        remoteData.mediaObject = mediaItems
        var actualValue: SearchViewModel.MediaSnapshot?
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        sut.bindSnapshot { snapshot in
            actualValue = snapshot
            expectation.fulfill()
        }
        sut.searchMedia(keyword: "No")
        wait(for: [expectation], timeout: 0.1)
        let snapshotItems  = actualValue?.numberOfItems
        
        XCTAssertEqual(mediaItems.count, snapshotItems)
    }
    
    func test_searchMedia_ShouldNoUpdateSnapshotDueToNoMediaType() {
        let mediaItems = [MediaDataObject(id: 1), MediaDataObject(id: 2)]
        remoteData.mediaObject = mediaItems
        let expectation = XCTestExpectation()
        var actualValue: SearchViewModel.MediaSnapshot?
        expectation.expectedFulfillmentCount = 1
        
        sut.bindSnapshot { snapshot in
            actualValue = snapshot
            expectation.fulfill()
        }
        sut.searchMedia(keyword: "No")
        wait(for: [expectation], timeout: 0.1)
        let snapshotItems  = actualValue?.numberOfItems
        
        XCTAssertEqual(0, snapshotItems)
    }
    
    func test_searchMedia_ErrorShouldUpdateBox() {
        remoteData.error = NSError(domain: "", code: -666)
        let expectation = XCTestExpectation()
        var actualValue: Error?
        expectation.expectedFulfillmentCount = 2
        
        sut.bindError { error in
            actualValue = error
            expectation.fulfill()
        }
        sut.searchMedia(keyword: "No")
        wait(for: [expectation], timeout: 0.1)
        
        XCTAssertNotNil(actualValue)
    }

}


extension MediaTableViewCellModel: Equatable {
    public static func == (lhs: MediaTableViewCellModel, rhs: MediaTableViewCellModel) -> Bool {
        lhs.rated == rhs.rated && lhs.title == rhs.title && lhs.image == rhs.image && lhs.defaultImage == rhs.defaultImage && lhs.subtitle == rhs.subtitle && lhs.footNote == rhs.footNote
    }
}
