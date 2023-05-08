//
//  FavouritesLocalDataTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 08/05/23.
//

import XCTest
@testable import BAZProject

final class FavouritesLocalDataTests: XCTestCase {

    func test_getFavouriteMedia_ShouldGetMockedData() throws {
        let mediaItems = [MediaItem(), MediaItem()]
        let udMock = UserDefaultsMock()
        udMock.data = try JSONEncoder().encode(mediaItems)
        let sut = FavouritesLocalData(udManager: udMock)
        
        let items = try sut.getFavourites()
        
        XCTAssertEqual(items?.count, mediaItems.count)
    }
    
    func test_getRecentlySearchedMedia_ShouldGetNil() throws {
        let udMock = UserDefaultsMock()
        let sut = FavouritesLocalData(udManager: udMock)
        
        let items = try sut.getFavourites()
        
        XCTAssertNil(items)
    }

}
