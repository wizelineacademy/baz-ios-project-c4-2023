//
//  DetailViewTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import Foundation
import XCTest
import BAZProject

final class DetailViewTest: XCTestCase {
    var sut: DetailViewController?
    var presenter: DetailPresentationLogic?
    var info: CellPersonalizedTableViewProtocol?
    var arrSimilar: [CellPersonalizedTableViewProtocol]?
    var arrReviews: [CellPersonalizedTableViewProtocol]?
    var arrCast: [CellPersonalizedTableViewProtocol]?
    
    override func setUp() {
        super.setUp()
        sut = DetailViewController(nibName: "DetailViewController", bundle: Bundle(for: DetailViewController.self))
        sut?.interactor = self
        sut?.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        info = nil
        arrSimilar = nil
        arrReviews = nil
        arrCast = nil
    }
    
    func testNavigationTitleUpdated() {
        //Then
        XCTAssertEqual(info?.strTitle, sut?.navigationItem.title)
    }
   
    func testFirstSectionUpdatedRows() {
        //Given
        let iRowsExpected = 1
        //When
        let iReal = sut?.tblMovieInfo.numberOfRows(inSection: 0)
        //Then
        XCTAssertEqual(iRowsExpected, iReal)
    }
    
    func testFirstSectionIsNotEmpty() {
        //Given
        let indexPath = IndexPath(row: 0, section: 0)
        //When
        sut?.tblMovieInfo.reloadData()
        let cell = sut?.tblMovieInfo.cellForRow(at: indexPath) as? ImageTextTableViewCell
        //Then
        XCTAssertEqual(cell?.lblTitle.text, info?.strTitle)
    }
    
    func testSecondSectionIsUpdated() {
        //Given
        let iTotal = 2
        //When
        searchForReview()
        let iReal = sut?.tblMovieInfo.numberOfRows(inSection: 2)
        //Then
        XCTAssertEqual(iTotal, iReal)
    }
    
    func testSecondSectionHasInfo() {
        //Given
        let indexPath = IndexPath(row: 0, section: 2)
        //When
        sut?.tblMovieInfo.reloadData()
        let cell = sut?.tblMovieInfo.cellForRow(at: indexPath) as? ReviewTableViewCell
        //Then
        XCTAssertEqual(cell?.lblReview.text, arrReviews?.first?.strOverView)
    }
    
    func testThirdSectionHasUpdatedRows() {
        //Given
        let iTotal = 3
        //When
        searchForSimilar()
        let iReal = sut?.tblMovieInfo.numberOfRows(inSection: 3)
        //Then
        XCTAssertEqual(iTotal, iReal)
    }
    
    func testThirdSectionHasInfo() {
        //Given
        let indexPath = IndexPath(row: 1, section: 3)
        //When
        sut?.tblMovieInfo.reloadData()
        let cell = sut?.tblMovieInfo.cellForRow(at: indexPath) as? ImageTextTableViewCell
        //Then
        XCTAssertEqual(cell?.lblTitle.text, arrSimilar?[1].strTitle)
    }
    
    func testCastIsUpdated() {
        //Given
        let iTotal = 3
        //When
        searcForCast()
        let iReal = sut?.tblMovieInfo.numberOfRows(inSection: 1)
        //Then
        XCTAssertEqual(iTotal, iReal)
    }
    
    func testCastHasInfo() {
        //Given
        let indexPath = IndexPath(row: 2, section: 1)
        //When
        searcForCast()
        sut?.tblMovieInfo.reloadData()
        let cell = sut?.tblMovieInfo.cellForRow(at: indexPath) as? ImageTextTableViewCell
        //Then
        XCTAssertEqual(cell?.lblTitle.text, arrCast?[2].strTitle)
    }
    
    func testButtonFunctions() {
        //Given
        sut?.favoriteStatus(with: true)
        //When
        sut?.saveButtonWasTouch()
        //Then
        XCTAssertFalse(sut?.bIsFavorite ?? true)
    }
    
    func testDoubleTapIsFalse() {
        //Given
        sut?.favoriteStatus(with: true)
        //When
        sut?.saveButtonWasTouch()
        sut?.saveButtonWasTouch()
        //Then
        XCTAssertTrue(sut?.bIsFavorite ?? false)
    }
}

extension DetailViewTest: DetailBusinessLogic {
    func buttonWasTouched() {
        sut?.bIsFavorite = !(sut?.bIsFavorite ?? false)
    }
    
    func getCurrentData() {
        info = Movie(id: 1, title: "Prueba de inyección", poster_path: "/Kohane.jpg", overview: "No hay", release_date: "2023-12-14")
        sut?.updateTable(withCurrentInfo: info)
    }
    
    func searchForSimilar() {
        arrSimilar = [Movie(id: 1, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: ""), Movie(id: 2, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: ""), Movie(id: 3, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: "")]
        sut?.reloadSimilarMovies(with: arrSimilar!)
    }
    
    func searchForReview() {
        arrReviews = [Review(strReview: "Una review", strAuthor: "Un autor"), Review(strReview: "Una review2", strAuthor: "Un autor2")]
        sut?.reloadReviews(with: arrReviews!)
    }
    
    func searcForCast() {
        arrCast = [Cast(strName: "Un nombre", strProfilePath: "Kohane.jpg", strCharacter: "Kohane"), Cast(strName: "Otro nombre", strProfilePath: "Kohane2.jpg", strCharacter: "Kohane Azusawa"), Cast(strName: "Otro nombre 3", strProfilePath: "Kohane3.jpg", strCharacter: "Kohane Azusawa")]
        sut?.reloadCast(withCast: arrCast!)
    }
}
