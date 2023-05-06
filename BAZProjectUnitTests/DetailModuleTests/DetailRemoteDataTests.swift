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
        requestSession.data = DataStubs().movieDetailData
        
        let retrievedData = try await sut.getMovieDetails(id: 18)
        
        XCTAssertEqual(expectedData, retrievedData)
    }
    
    func test_getDetailData_ShouldReturnTVDetailDataObject() async throws {
        let recommendation = GenericResponseDataObject(results: [MediaDataObject(id: 11294, title: nil, posterPath: "/10XpD4aEOExWcOg9bxCA28NNsMQ.jpg", mediaType: "tv", voteAverage: 7.48, name: "Kitchen Nightmares", releaseDate: nil, profilePath: nil)])
        let similar = GenericResponseDataObject(results: [MediaDataObject(id: 87415, title: nil, posterPath: "/pah40fuJA2tZBcY1rhvpSlj0Ys1.jpg", mediaType: nil, voteAverage: 6.4, name: "Shadow", releaseDate: nil, profilePath: nil)])
        let reviews = ReviewCollectionDataOject(reviews:[ReviewDataObject(author: "Peter89Spencer", content: "I quickly watched the pilot episode. It wasn't bad. I am annoyed though that it never got picked for a series.")])
        let cast = CastDataObject(cast: [CastMemberDataObject(id: 89547, name: "Brian Dobson", profilePath: "/3klT2K1UGl1wvmHKuDcSPuUFasV.jpg", character: "Ben Grimm (voice)", order: 0)])
        let expectedData = TVDetailDataObject(id: 18, name: "W*A*L*T*E*R", overview: "W*A*L*T*E*R is a pilot for a spin-off of M*A*S*H made in 1984 that was never picked up. It starred Gary Burghoff, who reprised his M*A*S*H character.\n\nThe show relates the adventures of Corporal Walter O'Reilly after he returns home from the Korean War. He is no longer calling himself \"Radar\" and has moved away from Iowa after he sent his mother to live with his aunt. Settling in St. Louis, Missouri, by the beginning of the series he has become a police officer, though his character is still as in the original series.", posterPath: "/fwSw4fl08MVl5w6Q9lVUGIFkZQ2.jpg", originalName: "W*A*L*T*E*R", voteAverage: 5.643, status: "Ended", recommendations: recommendation, similar: similar, reviews: reviews, credits: cast)
        requestSession.data = DataStubs().tvDetailData
        
        let retrievedData = try await sut.getTVDetails(id: 18)
        
        XCTAssertEqual(expectedData.id, retrievedData?.id)
        XCTAssertEqual(expectedData.name, retrievedData?.name)
        XCTAssertEqual(expectedData.overview, retrievedData?.overview)
        XCTAssertEqual(expectedData.posterPath, retrievedData?.posterPath)
        XCTAssertEqual(expectedData.originalName, retrievedData?.originalName)
        XCTAssertEqual(expectedData.voteAverage, retrievedData?.voteAverage)
        XCTAssertEqual(expectedData.status, retrievedData?.status)
        XCTAssertEqual(expectedData.recommendations, retrievedData?.recommendations)
        XCTAssertEqual(expectedData.similar, retrievedData?.similar)
        XCTAssertEqual(expectedData.reviews, retrievedData?.reviews)
        XCTAssertEqual(expectedData.credits, retrievedData?.credits)
        
    }

}
