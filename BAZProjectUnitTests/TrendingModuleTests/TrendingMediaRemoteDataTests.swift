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
    
    func test_getTrendingItems_shouldGetDataFromRequestHandler() async throws {
        let data = DataStubs.completeData
        let item = [try GenericResponseDataObject(data: data)]
    }

}
