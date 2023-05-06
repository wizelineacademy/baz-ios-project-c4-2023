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
        let recommendation = GenericResponseDataObject(results: [MediaDataObject(id: 607, title: "Men in Black", posterPath: "/uLOmOF5IzWoyrgIF5MfUnh5pa1X.jpg", mediaType: "movie", voteAverage: 7.18, name: nil, releaseDate: "1997-07-02", profilePath: nil)])
        let similar = GenericResponseDataObject(results: [MediaDataObject(id: 2486, title: "Eragon", posterPath: "/k8f8WZjTzZ6TJYrKpyayCB4zKlw.jpg", mediaType: nil, voteAverage: 5.066, name: nil, releaseDate: "2006-12-14", profilePath: nil)])
        let reviews = ReviewCollectionDataOject(reviews:[ReviewDataObject(author: "GeekMasher", content: "This movie is one of the best movies of all time! It has a great story lines and graphics of it's time and even to today's standards it is brilliant. The world is well though out and well demonstrated. Zorg is a great bad guy, played by Gary Oldman and Bruce Willis plays his role very well. All in all a excellent movie.")])
        let cast = CastDataObject(cast: [CastMemberDataObject(id: 62, name: "Bruce Willis", profilePath: "/caX3KtMU42EP3VLRFFBwqIIrch5.jpg", character: "Korben Dallas", order: 0)])
        let expectedData = MovieDetailDataObject(id: 18, title: "The Fifth Element", originalTitle: "The Fifth Element", overview: "In 2257, a taxi driver is unintentionally given the task of saving a young girl who is part of the key that will ensure the survival of humanity.", posterPath: "/fPtlCO1yQtnoLHOwKtWz7db6RGU.jpg", voteAverage: 7.524, recommendations: recommendation, reviews: reviews, similar: similar, credits: cast)
        requestSession.data = DataStubs().detailData
        
        let retrievedData = try await sut.getMovieDetails(id: 18)
        
        XCTAssertEqual(expectedData, retrievedData)
    }

}
