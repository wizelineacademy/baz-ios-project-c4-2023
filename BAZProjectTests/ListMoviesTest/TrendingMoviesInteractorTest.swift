//
//  TrendingMoviesInteractorTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesInteractorTest: XCTestCase {

    private var sut: MoviesInteractorMock!
    private var fakeMovieApi: FakeMovieApi!
    private var presenter: MoviesPresenterMock!
    
    override func setUp() {
        super.setUp()
        fakeMovieApi = FakeMovieApi(resultType: .sucess)
        presenter = MoviesPresenterMock(router: MoviesRouter())
        sut = MoviesInteractorMock(movieAPI: fakeMovieApi)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovieApi = nil
        presenter = nil
    }
    
    func test_getMovies_callsApiAndSendInfo(){
        guard let request = ViewControllerElements.topRated.urlRequest else { return }
        sut.getMovies(urlRequest: request)
        XCTAssertEqual(sut.calls, [.getMovies])
    }
    
    
    func test_findMovies_returnsMovies(){
        let searchText = "TextToSearch"
        sut.findMovies(for: searchText)
        XCTAssertEqual(sut.calls, [.findMovies])
    }


}
