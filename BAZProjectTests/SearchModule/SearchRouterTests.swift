//
//  SearchRouterTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 14/05/23.
//

import XCTest
@testable import BAZProject

final class SearchRouterTests: XCTestCase {

    var sut: SearchRouter!
    
    override func setUp() {
        sut = SearchRouter()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_CreateModule(){
        XCTAssertNotNil(SearchRouter.createSearchModule())
    }
}
