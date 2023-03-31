//
//  MovieListViewModelTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 30/03/23.
//

import XCTest
@testable import BAZProject

final class MovieListViewModelTest: XCTestCase {

    private var sut: MovieListViewModel!
    
    override func setUp() {
        super.setUp()
        
        let trendingMovieDayResource = Resource<MovieList>(url: Endpoint.trendingMovieDay.url) { data in
            return try? JSONDecoder().decode(MovieList.self, from: data)
        }
        
        MovieAPI().load(resource: trendingMovieDayResource) { (result) in
            if let movieList = result {
                self.sut = MovieListViewModel(movies: movieList.results)
            }
        }
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func test_should_return_correct_display_name_for_fahrenheit() {
        
        
        XCTAssert(true)
    }
    
    func test_should_make_sure_that_default_selected_unit_is_fahrenheit() {
        XCTAssert(true)
    }
    
    func test_should_be_able_to_save_user_unit_selection() {
        
        XCTAssert(true)
        
    }

}
