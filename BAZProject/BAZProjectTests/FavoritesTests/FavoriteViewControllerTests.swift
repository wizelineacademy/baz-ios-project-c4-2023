//
//  FavoriteViewControllerTests.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//
import XCTest
@testable import BAZProject

final class FavoriteViewControllerTests: XCTestCase {

    func test_rowsNotZero() {
        //Given
        let sut = UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "Main") as! FavoritesViewController
        let viewModel = FavoriteViewModelMock()
        sut.ViewModel = viewModel
        let movies = [Movie(), Movie()]
        viewModel.movies = movies
        //Then
        sut.loadViewIfNeeded()
        let rows = sut.tableView.numberOfRows(inSection: 0)
        //When
        XCTAssertEqual(movies.count, rows)
    }
    
    func test_HeigthGrown_WhenEmplyMovie() {
        //Given
        let sut = UIStoryboard(name: "Favorites", bundle: nil).instantiateViewController(withIdentifier: "Main") as! FavoritesViewController
        let viewModel = FavoriteViewModelMock()
        sut.ViewModel = viewModel
        let movies = [Movie(), Movie()]
        viewModel.movies = movies
        //Then
        sut.loadViewIfNeeded()
        let rows = sut.tableView.estimatedRowHeight
        //When
        XCTAssertEqual(-1, rows)
    }
}

