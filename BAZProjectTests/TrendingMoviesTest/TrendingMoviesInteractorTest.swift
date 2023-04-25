//
//  TrendingMoviesInteractorTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesInteractorTest: XCTestCase {

    private var sut: TrendingMoviesInteractorMock!
    private var fakeMovieApi: FakeMovieApi!
    private var presenter: TrendingMoviesPresenterMock!
    
    override func setUp() {
        super.setUp()
        fakeMovieApi = FakeMovieApi(resultType: .sucess)
        presenter = TrendingMoviesPresenterMock()
        sut = TrendingMoviesInteractorMock(movieAPI: fakeMovieApi)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovieApi = nil
        presenter = nil
    }
    
    func test_getMovies_callsApiAndSendInfo(){
        sut.getMovies()
        XCTAssertEqual(sut.calls, [.getMovies])
    }
    
    func test_getRemotImage_getRemoteImage(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        sut.getRemotImage(from: "/8c4a8kE7PizaGQQnditMmI1xbRp.jpg") { imagen in
            XCTAssertNotNil(imagen)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
        XCTAssertEqual(sut.calls, [.getRemotImage])
    }
    
    func test_findMovies_returnsMovies(){
        sut.findMovies(for: "The Matrimony") { movies in
            XCTAssertNotNil(movies)
        }
        XCTAssertEqual(sut.calls, [.findMovies])
    }
    
    func test_getURL(){
        let searchText = "The Matrimony"
        let urlGiven = sut.getSearchMoviewUrlRequest(searchString: searchText)?.url?.absoluteString
        let expectedUrl = "https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&query=%54%68%65%4D%61%74%72%69%6D%6F%6E%79"
        XCTAssertEqual(urlGiven, expectedUrl)
    }


}
