//
//  FavoriteTableViewCellTests.swift
//  BAZProject
//
//  Created by Manuel S on 06/05/23.
//

import XCTest
@testable import BAZProject

final class FavoriteTableViewCellTests: XCTestCase {
    
    var sut: FavoriteTableViewCell?
    var viewModel: FavoritesViewModel?

    override func setUp() {
        super.setUp()
        
        sut = try! FavoriteTableViewCell.fromNib()
        viewModel =  FavoritesViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFavoriteViewCell_TableViewTitleCell_NotNil() {
        //Given
        let expectedResult: [InfoMoviesProtocol] = [Movie(id: 1, title: "Lego Movie", poster_path: "Emet.jpg", overview: "Todo es increible", vote_average: 10)]
        //Then
        viewModel!.favoriteMovies = Box(value: expectedResult)
        sut?.setInfo(viewModel!, indexPath: IndexPath(row: 0, section: 0))
        //When
        XCTAssertNotNil(sut?.labelText.text)
    }
    
    func testTrendingViewCell_TableViewTitleCell_Empty() {
        //Given
        let expectedResult: [InfoMoviesProtocol] = [Movie(id: 1, title: "Lego Movie", poster_path: "Emet.jpg", overview: "Todo es increible", vote_average: 10)]
        //Then
        viewModel!.favoriteMovies = Box(value: expectedResult)
        sut?.awakeFromNib()
        //Then
        XCTAssertEqual(sut?.labelText.text, "")
    }
}
