//
//  MoviesDetailViewTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 05/05/23.
//

import XCTest
@testable import BAZProject

final class MoviesDetailViewTest: XCTestCase {
    
    var sut         : MoviesDetailView!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = MoviesDetailView()
        sut.loadViewIfNeeded()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    // MARK: View - Test
    // Validate backgroundColor of the view
    func test_SearchMoviesView_BackgroundColor() {
        XCTAssertEqual(sut.view.backgroundColor, .systemBackground)
    }
    
    // Validate title is nil
    func test_SearchMoviesViewTitleIsNotNil() {
        XCTAssertNil(sut.title)
    }
    
    // validate title is empety
    func test_SearchMoviesViewIsEmptyTitle() {
        //Given
        let expected = ""
        //When
        let titleNav = sut.title ?? ""
        //Then
        XCTAssertEqual(expected, titleNav)
    }
    
    // MARK: Button - Test
    func test_ButtonFavoritesHasSetImageView() {
        XCTAssertNotNil(sut.btnLikes.imageView)
    }
    
    // MARK: TableView - Test
    func test_CollectionHasSetDatasource() {
        XCTAssertNotNil(sut.collectionRecomendations.dataSource)
    }
    
    func test_Collection_WhenCellRowHasZeroElements(){
        XCTAssertEqual(sut.collectionRecomendations.dataSource?.collectionView(sut.collectionRecomendations, numberOfItemsInSection: 0), 0)
    }

}
