//
//  FavoriteViewControllerTests.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//
import XCTest
@testable import BAZProject

final class FavoriteViewControllerTests: XCTestCase {
    
    
    
    var sut: FavoritesViewController!
    var model: FavoritesViewModelMock!
    
    override func setUp() {
        super.setUp()
        sut = UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "Main") as! FavoritesViewController
        model = FavoritesViewModelMock()
        sut.ViewModel = model
    }

    override func tearDown() {
        super.tearDown()
        model = nil
    }

    func test_rowsNotZero() {
        //Given
        let movies = [Movie(), Movie()]
        model.movies = movies
        //Then
        sut.loadViewIfNeeded()
        let rows = sut.tableView.numberOfRows(inSection: 0)
        //When
        XCTAssertEqual(movies.count, rows)
    }
    
    func test_HeigthGrown_WhenEmplyMovie() {
        //Given
        let movies = [Movie(), Movie()]
        model.movies = movies
        //Then
        sut.loadViewIfNeeded()
        let rows = sut.tableView.estimatedRowHeight
        //When
        XCTAssertEqual(-1, rows)
    }
}

