//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by bvelazquezva on 29/03/23.
//

import XCTest
@testable import BAZProject

class BAZProjectTests: XCTestCase {
    
    var trendingPresenter: TrendingPresenter?
    var trendingPresenterMock: TrendingPresenterMock?
        
    var searchPresenter: SearchPresenter?
    var searchPresenterMock: SearchPresenterMock?
        
    var resulTrending: [Movie] = []
    var searchQuery = "John Wick"

    override func setUp(){
        super.setUp()
        trendingPresenter = TrendingPresenter()
        trendingPresenterMock = TrendingPresenterMock()
        
        searchPresenter = SearchPresenter()
        searchPresenterMock = SearchPresenterMock(tableView: UITableView())
    }

    override func tearDown(){
        super.tearDown()
        trendingPresenter = nil
        trendingPresenterMock = nil
        
        searchPresenter = nil
        searchPresenterMock = nil
    }

    func test_DataMovieResponse(){
        //Give
        var expetationMovies: [Movie] = []
        trendingPresenterMock?.willFetchMovies()
        expetationMovies = trendingPresenterMock?.result ?? []
        //When
        var result: [Movie] = []
        trendingPresenter?.willFetchMovies()
        result = trendingPresenter?.entity.result ?? []
        
        
        //Then
        XCTAssertEqual(expetationMovies, result)
    }
    
    func test_Data_NotNil(){
        //Give
        //When
        var result: [Movie] = []
        trendingPresenter?.willFetchMovies()
        result = trendingPresenter?.entity.result ?? []
        //Then
        XCTAssertNotNil(result)
    }
    
    func test_DataSearchMovieResponse(){
        //Give
        var expetationMovies: [Movie] = []
        searchPresenterMock?.willFetchMovies(searchQuery)
        expetationMovies = searchPresenterMock?.entity.result ?? []
        //When
        var result: [Movie] = []
        searchPresenter?.willFetchMovies(searchQuery)
        result = searchPresenter?.entity.result ?? []
        
        
        //Then
        XCTAssertEqual(expetationMovies, result)
    }
    
    func test_DataSearch_NotNil(){
        //Give
        //When
        var result: [Movie] = []
        searchPresenter?.willFetchMovies(searchQuery)
        result = searchPresenter?.entity.result ?? []
        //Then
        XCTAssertNotNil(result)
    }

}

/*func test_DataMovie(){
    //Give
    //When
    //Then
}*/
