//
//  TrendingViewModelTests.swift
//  BAZProjectTests
//
//  Created by Manuel S on 30/03/23.
//

import XCTest
@testable import BAZProject

final class TrendingViewModelTests: XCTestCase {
    
    var sut: TrendingViewModel?

    override func setUp(){
        super.setUp()
        sut = TrendingViewModel()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testTrendingModel_TableViewNotZerp(){
        //Given
        let movies = [Movie(id: 1, title: "Titanic", poster_path: "")]
        //When
        sut?.movies = Box(value: [ListMoviesProtocol]())
        let count = sut?.getMovieCount()
        //Then
        XCTAssertEqual(count, movies.count)
    }
}
