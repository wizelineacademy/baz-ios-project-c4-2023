//
//  DetailViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
@testable import BAZProject

final class DetailViewModelTests: XCTestCase {
    
    var sut: DetailViewModel!
    var remoteData: DetailRemoteDataMock!
    
    override func setUp() {
        super.setUp()
        remoteData = DetailRemoteDataMock()
    }
    
    override func tearDown() {
        sut = nil
        remoteData = nil
        super.tearDown()
    }
    
    func setViewModel(mediaItem: MediaItem) {
        sut = DetailViewModel(remoteData: remoteData, item: mediaItem)
    }
    
    func test_BindSnapshot_ShouldPerformBinding() {
        let expectation = XCTestExpectation()
        setViewModel(mediaItem: MediaItem())
        
        sut.bindSnapshot { snapshot in
            XCTAssertNotNil(snapshot)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
    }

    func test_getData_MovieItemDetailSectionsShouldBeEqual() {
        setViewModel(mediaItem: DataStubs.singleMovieMediaData)

        let sections = sut.getDetailSections()

        XCTAssertEqual(sections, [DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar])
    }

    func test_getData_TVItemDetailSectionsShouldBeEqual() {
        setViewModel(mediaItem: DataStubs.singleTVMediaData)

        let sections = sut.getDetailSections()

        XCTAssertEqual(sections, [DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar])
    }

    func test_getData_PersonItemDetailSectionsShouldBeEqual() {
        setViewModel(mediaItem: DataStubs.singlePersonMediaData)

        let sections = sut.getDetailSections()

        XCTAssertEqual(sections, [DetailSection.overview, DetailSection.filmography])
    }
    
}
