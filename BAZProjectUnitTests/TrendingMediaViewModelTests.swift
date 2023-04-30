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
        expectation.expectedFulfillmentCount = 3
        
        remoteData.mediaItems = mediaItems
        sut.loadData()
        sut.bindSnapshot {
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        let actualValue = self.sut.getDataSnapshot().numberOfItems(inSection: .movie)
        
        XCTAssertEqual(mediaItems.count, actualValue)
    }
    
    func test_GetMovies_Error() {
        let error = NSError(domain: "", code: -666)
        let expectation = XCTestExpectation()
        
        sut.bindError {
            expectation.fulfill()
        }
        remoteData.error = error
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
        let actualValue = sut.getError()
        
        XCTAssertNotNil(actualValue)
    }
    
    func test_GetMovies_MoviesCountShouldBeZeroByNilData() {
        let expectation = XCTestExpectation()
        
        sut.bindSnapshot {
            expectation.fulfill()
        }
        sut.loadData()
        wait(for: [expectation], timeout: 0.1)
        let actualValue = sut.getDataSnapshot().numberOfSections
        
        XCTAssertEqual(0, actualValue)
    }
    
    func test_getCellConfiguration_rated() {
        let item = MediaItem(id: 1, posterPath: "", title: "ti", rating: 1.0, mediaType: .movie, releaseDate: Date())
        let expectedModel = MediaCollectionViewCellModel(title: "ti", subtitle: "1.0", image: "", rated: true, defaultImage: MediaType.movie.defaultImage)
        
        let model = sut.getCellConfiguration(item: item)
        
        XCTAssertEqual(model, expectedModel)
    }
    
    func test_getCellConfiguration_notRated() {
        let item = MediaItem(id: 1, posterPath: "", title: "ti", rating: 1.0, mediaType: .movie, releaseDate: Calendar.current.date(byAdding: .day, value: 1, to: Date())!)
        let expectedModel = MediaCollectionViewCellModel(title: "ti", subtitle: "4/30/23", image: "", rated: false, defaultImage: MediaType.movie.defaultImage)
        
        let model = sut.getCellConfiguration(item: item)
        
        XCTAssertEqual(model, expectedModel)
    }
    
}
