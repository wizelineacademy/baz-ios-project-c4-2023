//
//  SearchLocalDataTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
@testable import BAZProject

final class SearchLocalDataTests: XCTestCase {

    func test_getRecentlySearchedMedia_ShouldGetMockedData() throws {
        let mediaItems = [MediaItem(), MediaItem()]
        let udMock = UserDefaultsMock()
        udMock.data = try JSONEncoder().encode(mediaItems)
        let sut = SearchLocalData(udManager: udMock)
        
        let items = try sut.getRecentlySearchedMedia()
        
        XCTAssertEqual(items?.count, mediaItems.count)
    }
}
