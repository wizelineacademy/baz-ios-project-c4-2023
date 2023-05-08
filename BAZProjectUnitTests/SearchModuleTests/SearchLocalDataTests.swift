//
//  SearchLocalDataTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
@testable import BAZProject

final class SearchLocalDataTests: XCTestCase {

    func test_getRecentlySearchedMedia_ShouldGetMockedData() {
        let sut = SearchLocalData()
        
        let items = sut.getRecentlySearchedMedia()
        
        XCTAssertNotNil(items)
    }
}
