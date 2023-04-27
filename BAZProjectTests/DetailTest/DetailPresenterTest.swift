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
    private var arrFinal: [ImageTextTableViewProtocol]?
    private var strError: String?
    private var savedInfo: ImageTextTableViewProtocol?
    
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
        let arrInitial: [ImageTextTableViewProtocol] = [Movie(id: 1, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: ""), Movie(id: 2, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: ""), Movie(id: 3, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: "")]
        //When
        sut?.similarMoviewsObtained(with: arrInitial)
        //Then
        XCTAssertEqual(iExpected, arrFinal?.count)
    }
    
    func testLoneResultDidNotChange() {
        //Given
        let iExpected = 1
        let arrInitial: [ImageTextTableViewProtocol] = [Movie(id: 1, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: "")]
        //When
        sut?.similarMoviewsObtained(with: arrInitial)
        //Then
        XCTAssertEqual(iExpected, arrFinal?.count)
    }
    
    func testVoidArray() {
        //Given
        let emptySearch = EmptySearch()
        let arrEmpty: [ImageTextTableViewProtocol] = [ImageTextTableViewProtocol]()
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
}

extension DetailPresenterTest: DetailSearchDisplayLogic {
    func updateTable(withCurrentInfo info: ImageTextTableViewProtocol?) {
        self.savedInfo = info
    }
    
    func reloadSimilarMovies(with arrSimilar: [ImageTextTableViewProtocol]) {
        self.arrFinal =  arrSimilar
    }
    
    func serviceDidFailed(with strMessage: String) {
        strError = strMessage
    }
}
