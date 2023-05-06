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
        sut = UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "Main") as? FavoritesViewController
        model = FavoritesViewModelMock()
        sut.viewModel = model
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
    
    func testFavoriteView_TitleIsEqualToViewModel() {
        //Given
        sut.loadViewIfNeeded()
        //When
        XCTAssertEqual(sut.navigationItem.title, "Favoritos")
    }
    
    func testFavoriteView_ButtonIsEqualToView() {
        //Given
        sut?.loadViewIfNeeded()
        //Then
        let button = sut.navigationItem.rightBarButtonItem?.tintColor
        //When
        XCTAssertNotEqual(button, UIColor(ciColor: .red))
    }
    
    func testFavoriteView_HeigthIsNotNil() {
        //Given
        sut?.loadViewIfNeeded()
        //Then
        let tamaño = sut.tableView.heightAnchor
        //When
        XCTAssertNotNil(tamaño)
    }
    
    func testFavoriteView_LabelIsNotNil() {
        //Given
        sut?.loadViewIfNeeded()
        sut.viewWillAppear(true)
        //Then
        let title = sut.title
        //When
        XCTAssertNotNil(title)
    }
}
