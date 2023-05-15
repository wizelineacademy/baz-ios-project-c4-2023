//
//  SearcInteractorTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import XCTest
@testable import BAZProject

final class SearcInteractorTests: XCTestCase {

    var sut: SearchInteractorInputProtocol!
    var remoteData: SearchRemoteDataManagerMock!
    var presenter: SearchPresenter!
    
    override func setUp() {
        super.setUp()
        sut = SearchInteractor()
        remoteData = SearchRemoteDataManagerMock()
        sut.remoteDatamanager = remoteData
        sut.presenter = presenter
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
        
    func testSearchResultsFetched() {
        XCTAssertFalse(((sut.presenter?.searchResultsFecthed(searchResults: [SearchResult]())) != nil))
    }
}
