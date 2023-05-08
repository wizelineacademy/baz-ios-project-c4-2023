//
//  SearchRemoteDataTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
@testable import BAZProject

final class SearchRemoteDataTests: XCTestCase {

    func test_SearchMedia_GetMockedItems() async throws {
        let requestSession = RequestSessionMock()
        requestSession.data = DataStubs.completeData
        let requestHandler = RequestHandlerMock(urlSession: requestSession)
        let searchRemote = SearchRemoteData(requestHandler: requestHandler)
        let expectedItems: [MediaDataObject]? = [MediaDataObject(id: 3465, title: "df_SAWERQ", posterPath: "path//")]
        
        let items = try await searchRemote.searchMedia("")
        
        XCTAssertEqual(items, expectedItems)
    }

}
