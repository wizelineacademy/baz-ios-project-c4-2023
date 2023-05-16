//
//  ReviewsTableViewControllerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 08/05/23.
//

import XCTest
@testable import BAZProject

final class ReviewsTableViewControllerTest: XCTestCase {
    
    ///Sut
    var sut : ReviewsTableViewController!
    
    ///Revies fake
    var reviews: [Review]!
    
    ///Inicializador de las variables para las unit Test
    override func setUp() {
        sut = ReviewsTableViewController(nibName: ReviewsTableViewController.identifier, bundle: nil)
        reviews = [Review(author: "fakeAutor",
                          authorDetails: AuthorDetails(name: "fakeAutor", username: "fakeAutor"),
                          content: "fakeAutor",
                          createdAt: "fakeAutor",
                          id: "fakeAutor",
                          updatedAt: "fakeAutor",
                          url: "fakeAutor"),
                   Review(author: "fakeAutor2",
                                     authorDetails: AuthorDetails(name: "fakeAutor2", username: "fakeAutor2"),
                                     content: "fakeAutor2",
                                     createdAt: "fakeAutor2",
                                     id: "fakeAutor2",
                                     updatedAt: "fakeAutor2",
                                     url: "fakeAutor2")]
    }
    
    ///Se  alimina la instancia de las variables para el test
    override func tearDown() {
        sut = nil
        reviews = nil
    }
    
    /// Test que evalua si se regresa correctamente el identiicador de celda
    func test_identidier_returnsClassName(){
        let name = "ReviewsTableViewController"
        XCTAssertEqual(ReviewsTableViewController.identifier, name)
        
    }
   
    /// Test que evalua si se agrega correctamente la informacion en el TableView
    func test_tableView(){
        sut.reviews = reviews
        let rows = sut.tableView.numberOfRows(inSection: 0)
        guard let cell = sut.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? ReviewTableViewCell else { return }
        
        cell.prepareForReuse()
        
        XCTAssertEqual(rows, 2)
        XCTAssertNotNil(cell)
        XCTAssertEqual(cell.lblReview.text, "")        
    }


}
