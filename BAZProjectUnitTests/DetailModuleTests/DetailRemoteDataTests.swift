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
        let data = DataStubs().movieDetailData
        let expectedData = try MovieDetailDataObject(data: data)
        requestSession.data = data
        
        let retrievedData = try await sut.getMovieDetails(id: 18)
        
        XCTAssertEqual(expectedData, retrievedData)
    }
    
    func test_getDetailData_ShouldReturnTVDetailDataObject() async throws {
        let data = DataStubs().tvDetailData
        let expectedData = try TVDetailDataObject(data: data)
        requestSession.data = data
        
        let retrievedData = try await sut.getTVDetails(id: 18)
        
        XCTAssertEqual(expectedData?.id, retrievedData?.id)
        XCTAssertEqual(expectedData?.name, retrievedData?.name)
        XCTAssertEqual(expectedData?.overview, retrievedData?.overview)
        XCTAssertEqual(expectedData?.posterPath, retrievedData?.posterPath)
        XCTAssertEqual(expectedData?.originalName, retrievedData?.originalName)
        XCTAssertEqual(expectedData?.voteAverage, retrievedData?.voteAverage)
        XCTAssertEqual(expectedData?.status, retrievedData?.status)
        XCTAssertEqual(expectedData?.recommendations, retrievedData?.recommendations)
        XCTAssertEqual(expectedData?.similar, retrievedData?.similar)
        XCTAssertEqual(expectedData?.reviews, retrievedData?.reviews)
        XCTAssertEqual(expectedData?.credits, retrievedData?.credits)
        
    }
    
    func test_getDetailData_ShouldReturnPersonDetailDataObject() async throws {
        let data = DataStubs().personDetailData
        let expectedData = try PersonDetailDataObject(data: data)
        requestSession.data = data
        
        let retrievedData = try await sut.getPersonDetails(id: 18)
        
        XCTAssertEqual(expectedData?.id, retrievedData?.id)
        XCTAssertEqual(expectedData?.name, retrievedData?.name)
        XCTAssertEqual(expectedData?.biography, retrievedData?.biography)
        XCTAssertEqual(expectedData?.profilePath, retrievedData?.profilePath)
        XCTAssertEqual(expectedData?.deathday, retrievedData?.deathday)
        XCTAssertEqual(expectedData?.birthday, retrievedData?.birthday)
        XCTAssertEqual(expectedData?.combinedCredits, retrievedData?.combinedCredits)
        
    }

}
