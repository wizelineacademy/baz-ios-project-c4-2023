//
//  DetailRemoteDataTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
@testable import BAZProject

final class DetailRemoteDataTests: XCTestCase {
    
    var sut: DetailRemoteData!
    var requestSession: RequestSessionMock!
    
    override func setUp() {
        super.setUp()
        requestSession = RequestSessionMock()
        let handler = RequestHandlerMock(urlSession: requestSession)
        sut = DetailRemoteData(sessionHandler: handler)
    }

    override func tearDown() {
        sut = nil
        requestSession = nil
        super.tearDown()
    }

    func test_getDetailData_ShouldReturnMovieDetailDataObject() async throws {
        let expectedData = [MovieDetailDataObject]()
        
        let retrievedData = try await sut.getMovieDetails(id: 0)
        
        XCTAssertEqual(expectedData, retrievedData)
    }

}
