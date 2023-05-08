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
    var udManager: UserDefaultsMock!
    
    override func setUp() {
        super.setUp()
        remoteData = DetailRemoteDataMock()
        udManager = UserDefaultsMock()
    }
    
    override func tearDown() {
        sut = nil
        remoteData = nil
        udManager = nil
        super.tearDown()
    }
    
    func setViewModel(mediaItem: MediaItem) {
        let localData = DetailLocalData(userDefaultsManager: udManager)
        sut = DetailViewModel(remoteData: remoteData, localData: localData, item: mediaItem)
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

        XCTAssertEqual(sections, [DetailSection.overview, DetailSection.cast, DetailSection.reviews, DetailSection.recommended, DetailSection.similar])
    }

    func test_getDetailSections_TVItemDetailSectionsShouldBeEqual() {
        setViewModel(mediaItem: DataStubs.singleTVMediaData)

        let sections = sut.getDetailSections()

        XCTAssertEqual(sections, [DetailSection.overview, DetailSection.cast, DetailSection.reviews, DetailSection.recommended, DetailSection.similar])
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
        XCTAssertEqual(data?.firstAirDate, expectedData?.firstAirDate)
        XCTAssertEqual(data?.lastAirDate, expectedData?.lastAirDate)
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
        let expectedDictionary = DataStubs.personDetailDictionary
        let person = try await sut.getPersonDetails(id: 12)!
        let dictionary = sut.buildDictionary(from: person)

        XCTAssertEqual(sut.getDetailSections()?.sorted(by: { $0.rawValue < $1.rawValue}), Array(dictionary.keys).sorted(by: { $0.rawValue < $1.rawValue}))
        XCTAssertEqual(expectedDictionary[.overview], dictionary[.overview])
        XCTAssertEqual(expectedDictionary[.filmography], dictionary[.filmography])
    }
    
    func test_formatMovieDataObject() async throws {
        let dataObject = try MovieDetailDataObject(data: DataStubs().movieDetailData)!
        setViewModel(mediaItem: DataStubs.singleMovieMediaData)
        remoteData.movieDetails = dataObject
        let expectedDictionary = DataStubs.movieDetailDictionary
        let movie = try await sut.getMovieDetails(id: 12)!
        let dictionary = sut.buildDictionary(from: movie)

        XCTAssertEqual(sut.getDetailSections()?.sorted(by: { $0.rawValue < $1.rawValue}), Array(dictionary.keys).sorted(by: { $0.rawValue < $1.rawValue}))
        XCTAssertEqual(expectedDictionary[.overview], dictionary[.overview])
        XCTAssertEqual(expectedDictionary[.cast], dictionary[.cast])
        XCTAssertEqual(expectedDictionary[.reviews], dictionary[.reviews])
        XCTAssertEqual(expectedDictionary[.similar], dictionary[.similar])
        XCTAssertEqual(expectedDictionary[.recommended], dictionary[.recommended])
    }
    
    func test_formatTVDataObject() async throws {
        let dataObject = try TVDetailDataObject(data: DataStubs().tvDetailData)!
        setViewModel(mediaItem: DataStubs.singleTVMediaData)
        remoteData.tvDetails = dataObject
        let expectedDictionary = DataStubs.tvDetailDictionary
        let tv = try await sut.getTVDetails(id: 12)!
        let dictionary = sut.buildDictionary(from: tv)

        XCTAssertEqual(sut.getDetailSections()?.sorted(by: { $0.rawValue < $1.rawValue}), Array(dictionary.keys).sorted(by: { $0.rawValue < $1.rawValue}))
        XCTAssertEqual(expectedDictionary[.overview], dictionary[.overview])
        XCTAssertEqual(expectedDictionary[.cast], dictionary[.cast])
        XCTAssertEqual(expectedDictionary[.reviews], dictionary[.reviews])
        XCTAssertEqual(expectedDictionary[.similar], dictionary[.similar])
        XCTAssertEqual(expectedDictionary[.recommended], dictionary[.recommended])
    }
    
    
    func test_setSnapshotWithDictionary_shouldUpdateSnapshotWithTV() throws {
        let dataObject = try TVDetailDataObject(data: DataStubs().tvDetailData)!
        setViewModel(mediaItem: DataStubs.singleTVMediaData)
        remoteData.tvDetails = dataObject
        let expectedDictionary = DataStubs.tvDetailDictionary
        var returnedSnapshot: DetailViewModel.DetailSnapshot?
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        sut.bindSnapshot { snapshot in
            returnedSnapshot = snapshot
            expectation.fulfill()
        }
        sut.setSnapshotWithDictionary(dictionary: expectedDictionary)
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(returnedSnapshot?.sectionIdentifiers, Array(expectedDictionary.keys).sorted(by: { $0.rawValue < $1.rawValue }))
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .reviews), expectedDictionary[.reviews])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .cast), expectedDictionary[.cast])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .similar), expectedDictionary[.similar])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .recommended), expectedDictionary[.recommended])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .overview), expectedDictionary[.overview])
    }
    
    func test_setSnapshotWithDictionary_shouldUpdateSnapshotWithPerson() throws {
        let dataObject = try PersonDetailDataObject(data: DataStubs().personDetailData)!
        setViewModel(mediaItem: DataStubs.singlePersonMediaData)
        remoteData.personDetails = dataObject
        let expectedDictionary = DataStubs.personDetailDictionary
        var returnedSnapshot: DetailViewModel.DetailSnapshot?
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        sut.bindSnapshot { snapshot in
            returnedSnapshot = snapshot
            expectation.fulfill()
        }
        sut.setSnapshotWithDictionary(dictionary: expectedDictionary)
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(returnedSnapshot?.sectionIdentifiers, Array(expectedDictionary.keys).sorted(by: { $0.rawValue < $1.rawValue }))
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .filmography), expectedDictionary[.filmography])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .overview), expectedDictionary[.overview])
    }
    
    func test_setSnapshotWithDictionary_shouldUpdateSnapshotWithMovie() throws {
        let dataObject = try MovieDetailDataObject(data: DataStubs().movieDetailData)!
        setViewModel(mediaItem: DataStubs.singleMovieMediaData)
        remoteData.movieDetails = dataObject
        let expectedDictionary = DataStubs.movieDetailDictionary
        var returnedSnapshot: DetailViewModel.DetailSnapshot?
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        sut.bindSnapshot { snapshot in
            returnedSnapshot = snapshot
            expectation.fulfill()
        }
        sut.setSnapshotWithDictionary(dictionary: expectedDictionary)
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(returnedSnapshot?.sectionIdentifiers, Array(expectedDictionary.keys).sorted(by: { $0.rawValue < $1.rawValue }))
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .reviews), expectedDictionary[.reviews])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .cast), expectedDictionary[.cast])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .similar), expectedDictionary[.similar])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .recommended), expectedDictionary[.recommended])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .overview), expectedDictionary[.overview])
    }
    
    func test_getDetails_shouldUpdateSnapshotWithTV() throws {
        let dataObject = try TVDetailDataObject(data: DataStubs().tvDetailData)!
        setViewModel(mediaItem: DataStubs.singleTVMediaData)
        remoteData.tvDetails = dataObject
        let expectedDictionary = DataStubs.tvDetailDictionary
        var returnedSnapshot: DetailViewModel.DetailSnapshot?
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        sut.bindSnapshot { snapshot in
            returnedSnapshot = snapshot
            expectation.fulfill()
        }
        sut.getDetails()
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(returnedSnapshot?.sectionIdentifiers, Array(expectedDictionary.keys).sorted(by: { $0.rawValue < $1.rawValue }))
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .reviews), expectedDictionary[.reviews])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .cast), expectedDictionary[.cast])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .similar), expectedDictionary[.similar])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .recommended), expectedDictionary[.recommended])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .overview), expectedDictionary[.overview])
    }
    
    func test_getDetails_shouldUpdateSnapshotWithPerson() throws {
        let dataObject = try PersonDetailDataObject(data: DataStubs().personDetailData)!
        setViewModel(mediaItem: DataStubs.singlePersonMediaData)
        remoteData.personDetails = dataObject
        let expectedDictionary = DataStubs.personDetailDictionary
        var returnedSnapshot: DetailViewModel.DetailSnapshot?
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        sut.bindSnapshot { snapshot in
            returnedSnapshot = snapshot
            expectation.fulfill()
        }
        sut.getDetails()
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(returnedSnapshot?.sectionIdentifiers, Array(expectedDictionary.keys).sorted(by: { $0.rawValue < $1.rawValue }))
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .filmography), expectedDictionary[.filmography])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .overview), expectedDictionary[.overview])
    }
    
    func test_getDetails_shouldUpdateSnapshotWithMovie() throws {
        let dataObject = try MovieDetailDataObject(data: DataStubs().movieDetailData)!
        setViewModel(mediaItem: DataStubs.singleMovieMediaData)
        remoteData.movieDetails = dataObject
        let expectedDictionary = DataStubs.movieDetailDictionary
        var returnedSnapshot: DetailViewModel.DetailSnapshot?
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        
        sut.bindSnapshot { snapshot in
            returnedSnapshot = snapshot
            expectation.fulfill()
        }
        sut.getDetails()
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(returnedSnapshot?.sectionIdentifiers, Array(expectedDictionary.keys).sorted(by: { $0.rawValue < $1.rawValue }))
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .reviews), expectedDictionary[.reviews])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .cast), expectedDictionary[.cast])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .similar), expectedDictionary[.similar])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .recommended), expectedDictionary[.recommended])
        XCTAssertEqual(returnedSnapshot?.itemIdentifiers(inSection: .overview), expectedDictionary[.overview])
    }
    
    func test_getDetails_shouldGetErrorDueToNoIDOrNoMediaType() throws {
        setViewModel(mediaItem: MediaItem())
        let expectation = XCTestExpectation()
        var actualError: NSError?
        let expectedError = NSError(domain: "DetailModule.NoID_NoMediaType", code: -666)
        expectation.expectedFulfillmentCount = 2
        
        sut.bindError { error in
            actualError = error as NSError?
            expectation.fulfill()
        }
        sut.getDetails()
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(actualError, expectedError)
    }
    
    func test_getDetails_shouldGetErrorDueRemoteError_movieCase() throws {
        setViewModel(mediaItem: DataStubs.singleMovieMediaData)
        let expectedError = NSError(domain: "OhNONONOStickToTheStuffYouKnow", code: -666)
        remoteData.error = expectedError
        let expectation = XCTestExpectation()
        var actualError: NSError?
        expectation.expectedFulfillmentCount = 2
        
        sut.bindError { error in
            actualError = error as NSError?
            expectation.fulfill()
        }
        sut.getDetails()
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(actualError, expectedError)
    }
    
    func test_getDetails_shouldGetErrorDueRemoteError_personCase() throws {
        setViewModel(mediaItem: DataStubs.singlePersonMediaData)
        let expectedError = NSError(domain: "OhNONONOStickToTheStuffYouKnow", code: -666)
        remoteData.error = expectedError
        let expectation = XCTestExpectation()
        var actualError: NSError?
        expectation.expectedFulfillmentCount = 2
        
        sut.bindError { error in
            actualError = error as NSError?
            expectation.fulfill()
        }
        sut.getDetails()
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(actualError, expectedError)
    }
    
    func test_getDetails_shouldGetErrorDueRemoteError_tvCase() throws {
        setViewModel(mediaItem: DataStubs.singleTVMediaData)
        let expectedError = NSError(domain: "OhNONONOStickToTheStuffYouKnow", code: -666)
        remoteData.error = expectedError
        let expectation = XCTestExpectation()
        var actualError: NSError?
        expectation.expectedFulfillmentCount = 2
        
        sut.bindError { error in
            actualError = error as NSError?
            expectation.fulfill()
        }
        sut.getDetails()
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssertEqual(actualError, expectedError)
    }
    
    func test_getTitle_ShouldGetMediaItemTitle() {
        let title = "High School Musical"
        let mediaItem = MediaItem(title: title)
        setViewModel(mediaItem: mediaItem)
        
        let actualTitle = sut.getTitle()
        
        XCTAssertEqual(title, actualTitle)
    }
    
    func test_InitialItemShouldBeFavourite() {
        udManager.data = Data()
        setViewModel(mediaItem: MediaItem())
        let expectation = XCTestExpectation()
        var fav = false
        
        sut.bindFavourite { bool in
            fav = bool
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssert(fav)
    }

    func test_getDataFromItem_DataShouldNotBeTheSame() throws {
        let mediaItem = MediaItem(id: 1, mediaType: .movie)
        setViewModel(mediaItem: mediaItem)
        
        let data = sut.getDataFromItem()!
        let decoded = try JSONDecoder().decode(MediaItem.self, from: data)

        XCTAssertEqual(mediaItem, decoded)
    }
    
    func test_saveData_RetrievedDataShouldBeEqual() {
        setViewModel(mediaItem: MediaItem(id: 1, mediaType: .movie))
        let expectation = XCTestExpectation()
        expectation.expectedFulfillmentCount = 2
        var fav = false
        
        sut.bindFavourite { bool in
            fav = bool
            expectation.fulfill()
        }
        sut.saveItem()
        wait(for: [expectation], timeout: 0.5)
        
        XCTAssert(fav)
    }
    
    func test_getDataFromItem_DataShouldThrowError() throws {
        let mediaItem = MediaItem(id: 1, mediaType: .movie)
        setViewModel(mediaItem: mediaItem)
        let encoderMock = EncoderMock()
        let expectation = XCTestExpectation()
        let expectedError = NSError(domain: "EstoyListo", code: -123)
        expectation.expectedFulfillmentCount = 2
        encoderMock.error = expectedError
        var theError: NSError?
        
        sut.bindError { error in
            theError = error as NSError?
            expectation.fulfill()
        }
        
        let data = sut.getDataFromItem(enconder: encoderMock)

        XCTAssertEqual(theError, expectedError)
    }
    
}
