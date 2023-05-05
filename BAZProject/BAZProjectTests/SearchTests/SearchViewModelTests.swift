//
//  SearchViewModelTests.swift
//  BAZProject
//
//  Created by Manuel S on 20/04/23.
//

import XCTest
@testable import BAZProject

final class SearchViewModelTests: XCTestCase {
    
    var sut: SearchViewModel?
    var sessionMock: SessionMock?

    override func setUp() {
        super.setUp()
        sessionMock = SessionMock()
        sut = SearchViewModel(service: ServiceAPI(session: sessionMock!))
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSearchModel_countNotNil() {
        //Given
        let movies = [Movie(id: 1, title: "Mario Bros", poster_path: "")]
        //When
        sut?.moviesSearched = Box(value: movies)
        let count = sut?.getMovieCount()
        //Then
        XCTAssertEqual(count, movies.count)
    }
    
    func testSearchModel_TitleNotNil() {
        //Given
        let movies = [Movie(id: 1, title: "Avatar", poster_path: "")]
        //When
        sut?.moviesSearched = Box(value: movies)
        let title = sut?.getTitle(index: 0)
        //Then
        XCTAssertEqual("Avatar", title)
    }
    
    func testSearch_isEmpty_WhenClean() {
        let movies = [Movie(id: 1, title: "Payasos asesinos del espacio exterior", poster_path: "")]
        //When
        sut?.moviesSearched = Box(value: movies)
        sut?.cleanMoviesArray()
        //Then
        XCTAssertNotNil(movies)
    }
    
    func testSearchModel_bindMovies() {
        //Given
        let movies = [Movie(id: 1, title: "Mario Bros", poster_path: "")]
        let expectation = XCTestExpectation(description: "Binding should call closure")
        //When
        sut?.bindMovies { expectation.fulfill() }
        sut?.moviesSearched.value = movies
        wait(for: [expectation], timeout: 0.1)
        let count = sut?.getMovieCount()
        //Then
        XCTAssertEqual(count, movies.count)
    }
    
    func test_searchMovie() throws {
        //Given
        let data = String("{\"results\":[{\"id\":1}]}").data(using: .utf8)
        let expectation = XCTestExpectation(description: "Binding should call closure")
        //When
        sut?.bindMovies { expectation.fulfill() }
        sessionMock?.data = data
        sut?.searchMovie("Mock", apiKey: "a", completion: { _ in })
        wait(for: [expectation], timeout: 0.1)
        let count = sut?.getMovieCount()
        //Then
        XCTAssertEqual(count, 1)
    }
    
    func test_searchMovie_DataWrongFormat() {
        //Given
        let data = String("{\"results\":{\"id\":1}}").data(using: .utf8)
        let expectation = XCTestExpectation(description: "Binding should call closure")
        //When
        sessionMock?.data = data
        sut?.searchMovie("Mock", apiKey: "a", completion: { _ in
            expectation.fulfill()
        })
        wait(for: [expectation], timeout: 0.1)
        let count = sut?.getMovieCount()
        //Then
        XCTAssertEqual(count, 0)
    }
    
    func test_searchMovie_PathExist()  {
        //Given
        let movies = [Movie(id: 1, title: "Avatar", poster_path: "Av.png")]
        //When
        sut?.moviesSearched = Box(value: movies)
        let path = sut?.getImagePath(index: 0)
        //Then
        XCTAssertEqual("Av.png", path)
    }
    
    func test_searchMovie_MovieInfoExist()  {
        //Given
        let movies = [Movie(id: 1, title: "Avatar", poster_path: "Av.png")]
        //When
        sut?.moviesSearched = Box(value: movies)
        let movie = sut?.getAllInfoMoview(index: 0)
        //Then
        XCTAssertNotNil(movie)
    }
}
