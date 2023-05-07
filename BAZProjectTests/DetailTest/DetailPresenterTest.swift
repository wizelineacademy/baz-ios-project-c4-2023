//
//  DetailPresenterTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import Foundation
import XCTest
import BAZProject

final class DetailPresenterTest: XCTestCase {
    var sut: DetailPresenter?
    var interactor: DetailBusinessLogic?
    private var arrFinal: [CellPersonalizedTableViewProtocol]?
    private var strError: String?
    private var savedInfo: CellPersonalizedTableViewProtocol?
    private var arrReviews: [CellPersonalizedTableViewProtocol]?
    private var arrCast: [CellPersonalizedTableViewProtocol]?
    
    override func setUp() {
        super.setUp()
        sut = DetailPresenter()
        sut?.view = self
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        arrFinal = nil
        strError = nil
        savedInfo = nil
        arrReviews = nil
        arrCast = nil
    }
    
    func testSavedDataIsSent() {
        //Given
        let savedMovie = Movie(id: 1, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: "")
        //When
        sut?.currentInfo(movie: savedMovie)
        //Then
        XCTAssertEqual(savedMovie.strTitle, savedInfo?.strTitle)
    }
    
    func testLargeArrayIsCutToTwo() {
        //Given
        let iExpected = 2
        let arrInitial: [CellPersonalizedTableViewProtocol] = [Movie(id: 1, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: ""), Movie(id: 2, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: ""), Movie(id: 3, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: "")]
        //When
        sut?.similarMoviewsObtained(with: arrInitial)
        //Then
        XCTAssertEqual(iExpected, arrFinal?.count)
    }
    
    func testLoneResultDidNotChange() {
        //Given
        let iExpected = 1
        let arrInitial: [CellPersonalizedTableViewProtocol] = [Movie(id: 1, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: "")]
        //When
        sut?.similarMoviewsObtained(with: arrInitial)
        //Then
        XCTAssertEqual(iExpected, arrFinal?.count)
    }
    
    func testVoidArray() {
        //Given
        let emptySearch = EmptySearch()
        let arrEmpty: [CellPersonalizedTableViewProtocol] = [CellPersonalizedTableViewProtocol]()
        //When
        sut?.similarMoviewsObtained(with: arrEmpty)
        //Then
        XCTAssertEqual(emptySearch.strTitle, arrFinal?.first?.strTitle)
    }
    
    func testMessageErrorIsSent() {
        //Given
        let strMessageExpected = ErrorApi.badJSON.getMessage()
        //When
        sut?.serviceDidFailed(with: .badJSON)
        //Then
        XCTAssertEqual(strMessageExpected, strError)
    }
    
    func testReviewsCutToFive() {
        //Given
        let arrReviews = [Review(strReview: "Una review", strAuthor: "Un autor"), Review(strReview: "Una review2", strAuthor: "Un autor"), Review(strReview: "Una review3", strAuthor: "Un autor"), Review(strReview: "Una review4", strAuthor: "Un autor"), Review(strReview: "Una review5", strAuthor: "Un autor"), Review(strReview: "Una review6", strAuthor: "Un autor"), Review(strReview: "Una review7", strAuthor: "Un autor")]
        let iExpected = 5
        //When
        sut?.reviewsWereObtained(with: arrReviews)
        //Then
        XCTAssertEqual(iExpected, self.arrReviews?.count)
    }
    
    func testLesThanFiveIsPreserved() {
        //Given
        let arrReviewsToTest = [Review(strReview: "Una review", strAuthor: "Un autor"), Review(strReview: "Una review2", strAuthor: "Un autor"), Review(strReview: "Una review3", strAuthor: "Un autor"), Review(strReview: "Una review4", strAuthor: "Un autor")]
        //When
        sut?.reviewsWereObtained(with: arrReviewsToTest)
        //Then
        XCTAssertEqual(arrReviewsToTest.count, self.arrReviews?.count)
    }
    
    func testCastCutToSeven() {
        //Given
        let arrCastToTest = [Cast(strName: "1", strProfilePath: "1", strCharacter: "1"), Cast(strName: "2", strProfilePath: "1", strCharacter: "1"), Cast(strName: "3", strProfilePath: "1", strCharacter: "1"), Cast(strName: "1", strProfilePath: "1", strCharacter: "1"), Cast(strName: "1", strProfilePath: "1", strCharacter: "1"), Cast(strName: "1", strProfilePath: "1", strCharacter: "1"), Cast(strName: "1", strProfilePath: "1", strCharacter: "1"), Cast(strName: "1", strProfilePath: "1", strCharacter: "1"), Cast(strName: "1", strProfilePath: "1", strCharacter: "1"), Cast(strName: "1", strProfilePath: "1", strCharacter: "1")]
        let iExpected = 7
        //When
        sut?.castobtained(with: arrCastToTest)
        //Then
        XCTAssertEqual(iExpected, self.arrCast?.count)
    }
    
    func testCastLestThanSevenPreserved() {
        let arrCastToTest = [Cast(strName: "1", strProfilePath: "1", strCharacter: "1"), Cast(strName: "2", strProfilePath: "1", strCharacter: "1"), Cast(strName: "3", strProfilePath: "1", strCharacter: "1")]
        //When
        sut?.castobtained(with: arrCastToTest)
        //Then
        XCTAssertEqual(arrCastToTest.count, self.arrCast?.count)
    }
}

extension DetailPresenterTest: DetailSearchDisplayLogic {
    func updateTable(withCurrentInfo info: CellPersonalizedTableViewProtocol?) {
        self.savedInfo = info
    }
    
    func reloadSimilarMovies(with arrSimilar: [CellPersonalizedTableViewProtocol]) {
        self.arrFinal =  arrSimilar
    }
    
    func reloadCast(withCast arrCast: [CellPersonalizedTableViewProtocol]) {
        self.arrCast = arrCast
    }
    
    func reloadReviews(with arrReviews: [CellPersonalizedTableViewProtocol]) {
        self.arrReviews = arrReviews
    }
    
    func serviceDidFailed(with strMessage: String) {
        strError = strMessage
    }
}
