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
    
    func test_NotNil_Presenter(){
        XCTAssertNotNil(sut?.view?.showResultMovies())
        XCTAssertNotNil(sut?.setError())
        XCTAssertNotNil(sut?.setResponseMovies(with: [MovieData]()))
    }

}
extension SearchMoviesPresenterTest: SearchMoviesViewInputProtocol{
    
    func showResultMovies() {
    }
    
}
