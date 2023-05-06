//
//  DetailViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 05/05/23.
//

import XCTest
@testable import BAZProject

final class DetailViewModelTests: XCTestCase {
    
    var sut: DetailViewModel!
    var remoteData: DetailRemoteDataMock!
    
    override func setUp() {
        super.setUp()
        remoteData = DetailRemoteDataMock()
    }
    
    override func tearDown() {
        sut = nil
        remoteData = nil
        super.tearDown()
    }
    
    func setViewModel(mediaItem: MediaItem) {
        sut = DetailViewModel(remoteData: remoteData, item: mediaItem)
    }
    
    func test_BindSnapshot_ShouldPerformBinding() {
        let expectation = XCTestExpectation()
        setViewModel(mediaItem: MediaItem())
        
        sut.bindSnapshot { snapshot in
            XCTAssertNotNil(snapshot)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.1)
        
    }

    func test_getDetailSections_MovieItemDetailSectionsShouldBeEqual() {
        setViewModel(mediaItem: DataStubs.singleMovieMediaData)

        let sections = sut.getDetailSections()

        XCTAssertEqual(sections, [DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar])
    }

    func test_getDetailSections_TVItemDetailSectionsShouldBeEqual() {
        setViewModel(mediaItem: DataStubs.singleTVMediaData)

        let sections = sut.getDetailSections()

        XCTAssertEqual(sections, [DetailSection.overview, DetailSection.cast, DetailSection.recommended, DetailSection.similar])
    }

    func test_getDetailSections_PersonItemDetailSectionsShouldBeEqual() {
        setViewModel(mediaItem: DataStubs.singlePersonMediaData)

        let sections = sut.getDetailSections()

        XCTAssertEqual(sections, [DetailSection.overview, DetailSection.filmography])
    }
    
    func test_getMovieDetails_ShouldBeEqualAsTheInjectedData() async throws {
        let expectedData = try MovieDetailDataObject(data: DataStubs().movieDetailData)
        setViewModel(mediaItem: DataStubs.singleMovieMediaData)
        remoteData.movieDetails = expectedData
        
        let data = try await sut.getMovieDetails(id: 18)
        
        XCTAssertEqual(data, expectedData)
    }
    
    func test_getTVDetails_ShouldBeEqualAsTheInjectedData() async throws {
        let expectedData = try TVDetailDataObject(data: DataStubs().tvDetailData)
        setViewModel(mediaItem: DataStubs.singleTVMediaData)
        remoteData.tvDetails = expectedData
        
        let data = try await sut.getTVDetails(id: 18)
        
        XCTAssertEqual(data?.overview, expectedData?.overview)
        XCTAssertEqual(data?.credits, expectedData?.credits)
        XCTAssertEqual(data?.reviews, expectedData?.reviews)
        XCTAssertEqual(data?.similar, expectedData?.similar)
        XCTAssertEqual(data?.first_air_date, expectedData?.first_air_date)
        XCTAssertEqual(data?.last_air_date, expectedData?.last_air_date)
        XCTAssertEqual(data?.status, expectedData?.status)
        XCTAssertEqual(data?.recommendations, expectedData?.recommendations)
    }
    
    func test_getPersonDetails_ShouldBeEqualAsTheInjectedData() async throws {
        let expectedData = try PersonDetailDataObject(data: DataStubs().personDetailData)
        setViewModel(mediaItem: DataStubs.singlePersonMediaData)
        remoteData.personDetails = expectedData
        
        let data = try await sut.getPersonDetails(id: 18)
        
        XCTAssertEqual(data?.deathday, expectedData?.deathday)
        XCTAssertEqual(data?.birthday, expectedData?.birthday)
        XCTAssertEqual(data?.combinedCredits, expectedData?.combinedCredits)
        XCTAssertEqual(data?.biography, expectedData?.biography)
    }
    
    func test_formatPersonDataObject() async throws {
        let dataObject = try PersonDetailDataObject(data: DataStubs().personDetailData)!
        setViewModel(mediaItem: DataStubs.singlePersonMediaData)
        remoteData.personDetails = dataObject
        let expectedDictionary: [DetailSection: [AnyHashable]] = [.overview: [OverviewModel(largeTitle: "Scott MacDonald", smallSubtitle: "Birth: 1/1/59", image: "/pBXNUejSwDHfWCD9GgmvRbIPBdb.jpg", description: "biography", defaultImage: nil)],
                                                                  .filmography: [MediaItem(id: 27318, posterPath: "/sXOATwGluNbb9ezfG6DvXCiXvJp.jpg", title: "Jack Frost", rating: 5.14, mediaType: .movie, releaseDate: DateFormatter.getDate(from: "1997-11-18"))]]
        let person = try await sut.getPersonDetails(id: 12)!
        let dictionary = sut.buildDictionary(from: person)

        XCTAssertEqual(sut.getDetailSections(), Array(dictionary.keys))
        XCTAssertEqual(expectedDictionary[.overview], dictionary[.overview])
        XCTAssertEqual(expectedDictionary[.filmography], dictionary[.filmography])
    }
    
    func test_formatMovieDataObject() async throws {
        let dataObject = try MovieDetailDataObject(data: DataStubs().movieDetailData)!
        setViewModel(mediaItem: DataStubs.singleMovieMediaData)
        remoteData.movieDetails = dataObject
        let expectedDictionary: [DetailSection: [AnyHashable]] =
            [.overview: [OverviewModel(largeTitle: "The Fifth Element", smallSubtitle: "1997", image: "/fPtlCO1yQtnoLHOwKtWz7db6RGU.jpg", description: "fifthElement", defaultImage: "poster")],
             .cast: [DetailCastMember(actor: MediaItem(id: 62, posterPath: "/caX3KtMU42EP3VLRFFBwqIIrch5.jpg", title: "Bruce Willis", rating: nil, mediaType: .person, releaseDate: nil), character: "Korben Dallas")],
             .similar: [MediaItem(id: 2486, posterPath: "/k8f8WZjTzZ6TJYrKpyayCB4zKlw.jpg", title: "Eragon", rating: 5.066, mediaType: .movie, releaseDate: DateFormatter.getDate(from: "2006-12-14"))],
             .recommended: [MediaItem(id: 607, posterPath: "/uLOmOF5IzWoyrgIF5MfUnh5pa1X.jpg", title: "Men in Black", rating: 7.18, mediaType: .movie, releaseDate: DateFormatter.getDate(from: "1997-07-02"))],
             .reviews: [DetailReview(author: "GeekMasher", content: "best movies", date: DateFormatter.getDate(from: "2021-06-23T15:57:20.936Z", format: "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"))]
            ]
        let movie = try await sut.getMovieDetails(id: 12)!
        let dictionary = sut.buildDictionary(from: movie)

        XCTAssertEqual(sut.getDetailSections()?.sorted(by: { $0.rawValue < $1.rawValue}), Array(dictionary.keys).sorted(by: { $0.rawValue < $1.rawValue}))
        XCTAssertEqual(expectedDictionary[.overview], dictionary[.overview])
        XCTAssertEqual(expectedDictionary[.cast], dictionary[.cast])
        XCTAssertEqual(expectedDictionary[.reviews], dictionary[.reviews])
        XCTAssertEqual(expectedDictionary[.similar], dictionary[.similar])
        XCTAssertEqual(expectedDictionary[.recommended], dictionary[.recommended])
    }
    
}
