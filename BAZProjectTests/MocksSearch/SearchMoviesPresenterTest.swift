//
//  SearchMoviesPresenterTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 20/04/23.
//

import XCTest
@testable import BAZProject

final class SearchMoviesPresenterTest: XCTestCase {
    
    private var sut: SearchMoviesPresenter?
    var presenter: BAZProject.SearchMoviesViewOutputProtocol?

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = SearchMoviesPresenter()
        sut?.view = self
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    // MARK: SetUpCorrect
    // Validate that elements are not null.
    func test_NotNil_Presenter(){
        XCTAssertNotNil(sut?.view?.showResultMovies())
        XCTAssertNotNil(sut?.setError())
        XCTAssertNotNil(sut?.setResponseMovies(with: [MovieData]()))
        XCTAssertNotNil(sut?.movies)
    }
    
    func test_MoviesHasZeroElements(){
        //Given
        let expected = 0
        //When
        let countMovies = sut?.movies.count ?? 0
        //Then
        XCTAssertEqual(expected, countMovies)
    }

}
extension SearchMoviesPresenterTest: SearchMoviesViewInputProtocol{
    
    func showResultMovies() {
    }
    
}
