//
//  TrendingTableViewCellTests.swift
//  BAZProject
//
//  Created by Manuel S on 06/05/23.
//

import XCTest
@testable import BAZProject

final class TrendingTableViewCellTests: XCTestCase {
    
    var sut: TrendingTableViewCell?
    var viewModel: TrendingViewModel?

    override func setUp() {
        super.setUp()
        
        sut = try! TrendingTableViewCell.fromNib()
        viewModel = TrendingViewModel()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testTrendingViewCell_TableViewTitleCell_NotNil() {
        //Given
        let expectedResult: [InfoMoviesProtocol] = [Movie(id: 1, title: "Titanic", poster_path: "")]
        //Then
        viewModel!.movies = Box(value: expectedResult)
        sut?.setInfo(viewModel!, indexPath: IndexPath(row: 0, section: 0))
        //When
        XCTAssertNotNil(sut?.titleLable)
    }
    
    func testTrendingViewCell_TableViewTitleCell_Empty() {
        //Given
        let expectedResult: [InfoMoviesProtocol] = [Movie(id: 1, title: "Titanic", poster_path: "")]
        //Then
        viewModel!.movies = Box(value: expectedResult)
        sut?.prepareForReuse()
        //Then
        XCTAssertEqual(sut?.titleLable.text, "")
    }
}
