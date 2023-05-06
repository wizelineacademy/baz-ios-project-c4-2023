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
        let expectedData = MovieDetailDataObject(id: 18, title: "The Fifth Element", originalTitle: "The Fifth Element", overview: "In 2257, a taxi driver is unintentionally given the task of saving a young girl who is part of the key that will ensure the survival of humanity.", posterPath: "/fPtlCO1yQtnoLHOwKtWz7db6RGU.jpg", voteAverage: 7.524)
        requestSession.data = DataStubs().detailData
        
        let retrievedData = try await sut.getMovieDetails(id: 18)
        
        XCTAssertEqual(expectedData, retrievedData)
    }

}
