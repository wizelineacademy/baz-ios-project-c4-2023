//
//  FavouritesLocalDataTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 08/05/23.
//

import XCTest
@testable import BAZProject

final class FavouritesLocalDataTests: XCTestCase {

    func test_GetFavouriteMedia_ShouldGetMockedData() throws {
        let mediaItems = [MediaItem(), MediaItem()]
        let udMock = UserDefaultsMock()
        udMock.data = try JSONEncoder().encode(mediaItems)
        let sut = FavouritesLocalData(udManager: udMock)
        
        let items = try sut.getFavourites()
        
        XCTAssertEqual(items?.count, mediaItems.count)
    }
    
    func test_GetFavourites_ShouldGetNil() throws {
        let udMock = UserDefaultsMock()
        let sut = FavouritesLocalData(udManager: udMock)
        
        let items = try sut.getFavourites()
        
        XCTAssertNil(items)
    }
    
    func test_RemoveFavourite_ShouldNotContainItem() throws {
        let item1 = MediaItem(id: 1)
        var itemArray = [MediaItem(id: 2), MediaItem(id: 3)]
        itemArray.append(item1)
        let udMock = UserDefaultsMock()
        udMock.data = try JSONEncoder().encode(itemArray)
        let sut = FavouritesLocalData(udManager: udMock)
        
        let fullFavs = try sut.getFavourites()
        try sut.removeFavourite(item1)
        let removedFavs = try sut.getFavourites()
        
        
        XCTAssertEqual(fullFavs?.count, itemArray.count)
        XCTAssertFalse(removedFavs?.contains(item1) ?? true)
        XCTAssertEqual(removedFavs?.count, itemArray.count - 1)
    }
    
    func test_RemoveFavourite_DeleteJustOneItemShouldNotContainItems() throws {
        let item1 = MediaItem(id: 1)
        var itemArray: [MediaItem] = []
        itemArray.append(item1)
        let udMock = UserDefaultsMock()
        udMock.data = try JSONEncoder().encode(itemArray)
        let sut = FavouritesLocalData(udManager: udMock)
        
        let fullFavs = try sut.getFavourites()
        try sut.removeFavourite(item1)
        let removedFavs = try sut.getFavourites()
        
        
        XCTAssertEqual(fullFavs?.count, itemArray.count)
        XCTAssertFalse(removedFavs?.contains(item1) ?? true)
        XCTAssertEqual(removedFavs?.count, itemArray.count - 1)
    }

}
