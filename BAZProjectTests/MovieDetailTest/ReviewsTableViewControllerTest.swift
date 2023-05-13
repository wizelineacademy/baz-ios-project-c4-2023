//
//  ReviewsTableViewControllerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 08/05/23.
//

import XCTest
@testable import BAZProject

final class ReviewsTableViewControllerTest: XCTestCase {

    var sut : ReviewsTableViewController!
    var reviews: [Review]!
    
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
    
    override func tearDown() {
        sut = nil
    }
    
    func test_identidier_returnsClassName(){
        let name = "ReviewsTableViewController"
        XCTAssertEqual(ReviewsTableViewController.identifier, name)
        
    }
    
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
