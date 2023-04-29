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
    var info: ImageTextTableViewProtocol?
    var arrSimilar: [ImageTextTableViewProtocol]?
    
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
    
    func testThirdSectionHasUpdatedRows() {
        //Given
        let iTotal = 3
        //When
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
}

extension DetailViewTest: DetailBusinessLogic {
    func getCurrentData() {
        info = Movie(id: 1, title: "Prueba de inyección", poster_path: "/Kohane.jpg", overview: "No hay", release_date: "2023-12-14")
        sut?.updateTable(withCurrentInfo: info)
    }
    
    func searchForSimilar() {
        arrSimilar = [Movie(id: 1, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: ""), Movie(id: 2, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: ""), Movie(id: 3, title: "Primer título", poster_path: "/Kohane.png", overview: "Un mensajes", release_date: "")]
        sut?.reloadSimilarMovies(with: arrSimilar!)
    }
}
