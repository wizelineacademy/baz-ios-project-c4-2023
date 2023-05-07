//
//  TrendingMediaRemoteDataTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 07/05/23.
//

import XCTest
@testable import BAZProject

final class TrendingMediaRemoteDataTests: XCTestCase {

    var sut: TrendingMediaRemoteData!
    var requestSession: RequestSessionMock!
    
    override func setUp() {
        super.setUp()
        requestSession = RequestSessionMock()
        let handler = RequestHandlerMock(urlSession: requestSession)
        sut = TrendingMediaRemoteData(requestHandler: handler)
    }

    override func tearDown() {
        sut = nil
        requestSession = nil
        super.tearDown()
    }
    
    func test_getTrendingItems_shouldGetDataFromRequestHandler_Trending() async throws {
        let data = DataStubs.completeData
        let expectedItem = try GenericResponseDataObject(data: data)?.results
        requestSession.data = data
        
        let item = try await sut.getMediaItems(section: .trending)
        
        XCTAssertEqual(item, expectedItem)
    }

}
