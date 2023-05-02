//
//  SearchViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 01/05/23.
//

import XCTest
@testable import BAZProject

final class SearchViewModelTests: XCTestCase {
    
    var sut: SearchViewModel!
    var remoteData: SearchRemoteDataMock!
    var localData: SearchLocalDataMock!

    override func setUp() {
        super.setUp()
        localData = SearchLocalDataMock()
        remoteData = SearchRemoteDataMock()
        sut = SearchViewModel(remoteData: remoteData, localData: localData)
    }

    override func tearDown() {
        localData = nil
        remoteData = nil
        sut = nil
        super.tearDown()
    }

    func testExample() throws {
        
    }

}
