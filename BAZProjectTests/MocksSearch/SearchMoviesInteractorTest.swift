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
    }
    
    override func tearDown()  {
        super.tearDown()
        sut = nil
        presenter = nil
    }
    
    // MARK: SetUpCorrect
    func testSearchServiceBlock(){
        XCTAssertNotNil(sut.consultServiceSearch(with: "hola"))
    }
    
    // MARK: Test - Functions
    func test_ZeroArray_MovieData(){
        consultServiceSearch(with: "Hola...")
        
        let resultExpected = [MovieData]()
        sut.presenter?.setResponseMovies(with: [MovieData]())
        XCTAssertEqual(presenter?.moviesMock.count, resultExpected.count)
    }
    
    func consultServiceSearch(with word: String) {
        sut.consultServiceSearch(with: word)
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
