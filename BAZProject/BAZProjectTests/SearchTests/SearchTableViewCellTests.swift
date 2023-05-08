//
//  SearchTableViewCellTests.swift
//  BAZProject
//
//  Created by Manuel S on 06/05/23.
//

import XCTest
@testable import BAZProject

final class SearchTableViewCellTests: XCTestCase {
    
    var sut: SearchTableViewCell?
    var viewModel: SearchViewModel?

    override func setUp() {
        super.setUp()
        
        sut = try! SearchTableViewCell.fromNib()
        viewModel = SearchViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSearchViewCell_TableViewTitleCell_NotNil() {
        //Given
        let expectedResult: [InfoMoviesProtocol] = [Movie(id: 1, title: "Avengers EndGame", poster_path: "A.jpg", overview: "Soy inevitable", vote_average: 10)]
        //Then
        viewModel!.moviesSearched = Box(value: expectedResult)
        sut?.setInfo(viewModel!, indexPath: IndexPath(row: 0, section: 0))
        //When
        XCTAssertNotNil(sut?.labelText.text)
    }
    
    func testSearchViewCell_TableViewTitleCell_Empty() {
        //Given
        let expectedResult: [InfoMoviesProtocol] = [Movie(id: 1, title: "Avengers EndGame", poster_path: "A.jpg", overview: "Soy inevitable", vote_average: 10)]
        //Then
        viewModel!.moviesSearched = Box(value: expectedResult)
        sut?.awakeFromNib()
        //Then
        XCTAssertEqual(sut?.labelText.text, "")
    }
}
