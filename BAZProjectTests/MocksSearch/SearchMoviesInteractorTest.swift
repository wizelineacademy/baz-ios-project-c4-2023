//
//  SearchMoviesInteractorTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 19/04/23.
//

import Foundation
import XCTest
@testable import BAZProject

final class SearchMoviesInteractorTest: XCTestCase{
    
    var presenter   : MockPresenter?
    var sut         : SearchMoviesInteractor!
    
    override func setUp() {
        super.setUp()
        sut = SearchMoviesInteractor(movieApi: MovieAPI(session: URLSession.shared))
        presenter = MockPresenter()
        sut.presenter = presenter
    }
    
    override func tearDown()  {
        super.tearDown()
        sut = nil
        presenter = nil
    }
    
    // MARK: SetUpCorrect
    // Valid consultServiceSearch is not nil
    func testSearchServiceBlock(){
        XCTAssertNotNil(sut.consultServiceSearch(with: "hola"))
    }
    
    // MARK: Test - Functions
    // Valid array MovieData is not nil
    func test_ZeroArray_MovieData(){
        consultServiceSearch(with: "Hola...")
        
        let resultExpected = [MovieData]()
        sut.presenter?.setResponseMovies(with: [MovieData]())
        XCTAssertEqual(presenter?.moviesMock.count, resultExpected.count)
    }
    
    func consultServiceSearch(with word: String) {
        sut.consultServiceSearch(with: word)
    }
    
    func testMovieDataTransformation() {
        // Given
        let movie = Movie(title: "", genreIds: [1])
        // When
        sut.setMovies(with: [movie])
        // Then
        XCTAssertEqual(presenter?.moviesMock.count, 1)
    }
    
}
class MockPresenter: SearchMoviesInteractorOutputProtocol {
    func setResponseMovies(with moviesData: [BAZProject.MovieData]) {
        moviesMock = moviesData
    }
    
    var moviesMock : [MovieData] = [MovieData]()
    
    func setError() {
        
    }
    
}
