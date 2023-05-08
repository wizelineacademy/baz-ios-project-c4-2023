//
//  DetailLocalDataTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 07/05/23.
//

import XCTest
@testable import BAZProject

final class DetailLocalDataTests: XCTestCase {
    
    var sut: DetailLocalData!
    var udManager: UserDefaultsMock!
    
    override func setUp() {
        super.setUp()
        udManager = UserDefaultsMock()
        sut = DetailLocalData(userDefaults: udManager)
    }
    
    override func tearDown() {
        sut = nil
        udManager = nil
        super.tearDown()
    }

    func test_SaveFavourite_ShouldSave() throws {
        let item = MediaItem()
        let arritem = [item]
        
        try sut.saveRecentlySearched(item)
        let retrieved = try sut.getExistingItems(key: "")
        
        XCTAssertEqual(retrieved, arritem)
    }
    
    func test_deleteFavourite_ShouldDelete() throws {
        let data = [MediaItem()]
        udManager.data = try JSONEncoder().encode(data)
        
        let existing = try sut.getExistingItems(key: "")
        XCTAssertEqual(existing?.count, data.count)
        
        try sut.saveOrDeleteFavourite(item: data.first!)
        let existingAfter = try sut.getExistingItems(key: "")
        
        XCTAssert(existingAfter!.isEmpty)
    }
    
}
