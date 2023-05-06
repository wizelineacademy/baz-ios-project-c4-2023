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

    func test_getData_SnapshotShouldGetMediaItemSections() {
        setViewModel(mediaItem: DataStubs.singleMovieMediaData)
        
        let sections = sut.getDetailSections()
        
        XCTAssertEqual(sections, [DetailSections.heading, DetailSections.overview, DetailSections.cast, DetailSections.recommended, DetailSections.similar])
    }

}
