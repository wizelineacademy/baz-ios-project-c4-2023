//
//  SearchInteractorTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 04/05/23.
//

import Foundation

import XCTest

@testable import BAZProject

final class SearchInteractorTests: XCTest {
    
    var sut: SearchInteractorInputProtocol!
    var remoteData: SearchRemoteDataManagerMock!
    
    override func setUp() {
        super.setUp()
        sut = SearchInteractor()
        remoteData = SearchRemoteDataManagerMock()
        sut.remoteDatamanager = remoteData
    }

    override func tearDown() {
       super.tearDown()
        sut = nil
        remoteData = nil
    }
    
    func testfetchSearchResults() {
        sut.fetchSearchResults(with: "Q")
        XCTAssert(remoteData.calls.contains(.fetchSearchResults))
    }
    
    func testSearchResults() {
        let expect = true
        sut.fetchSearchResults(with: "Q")
        XCTAssertEqual(expect, remoteData.calls.contains(.fetchSearchResults))
        
    }
    
}
