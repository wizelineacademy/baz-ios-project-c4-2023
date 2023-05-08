//
//  ApiTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 25/04/23.
//

import XCTest
@testable import BAZProject

final class ApiTest: XCTestCase {

    private var fakeMovies: [ListMovieProtocol]!
    private var sut: FakeMovieApi!
    
    override func setUp() {
        super.setUp()
        fakeMovies = []
        sut = FakeMovieApi(resultType: .sucess)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovies = nil
    }
    
    func test_ErrorApis(){
        let error = ApiError.defaultError
        XCTAssertEqual(error.localizedDescription, "Error por defecto")
    }
    
    func test_apicall_retrunSucess(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        guard let url = MovieCategories.topRated.urlRequest else { return }
        sut.fetch(request:url) {(result: Result<MovieResult?, Error>) in
            switch result {
            case .failure(let fail):
                print(fail)
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
}

final class ApiTestError: XCTestCase {

    private var fakeMovies: [ListMovieProtocol]!
    private var sut: FakeMovieApi!
    
    override func setUp() {
        super.setUp()
        fakeMovies = []
        sut = FakeMovieApi(resultType: .fail(ApiError.defaultError))
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovies = nil
    }
    
    func test_apicall_retrunError(){
        let expectation = XCTestExpectation(description: "Wait for getRemoteImage completion")
        guard let url = MovieCategories.topRated.urlRequest else { return }
        sut.fetch(request: url) {(result: Result<MovieResult?, Error>) in
            switch result {
            case .failure(let fail):
                XCTAssertNotNil(fail)
                expectation.fulfill()
            case .success(let response):
                print(response?.results?.first?.title ?? "")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func test_MoviesCategoriesEnum_returnVariables(){
        let endpointNowPlaying = BAZProject.MovieCategories.nowPlaying
        let endpointTopRated = BAZProject.MovieCategories.topRated
        let endpointPopular = BAZProject.MovieCategories.popular
        let endpointTrending = BAZProject.MovieCategories.trending
        let endpointUpComing = BAZProject.MovieCategories.upComing
        
        XCTAssertEqual(endpointNowPlaying.endPoint, "movie/now_playing")
        XCTAssertEqual(endpointTopRated.endPoint, "movie/top_rated")
        XCTAssertEqual(endpointPopular.endPoint, "movie/popular")
        XCTAssertEqual(endpointTrending.endPoint, "trending/movie/day")
        XCTAssertEqual(endpointUpComing.endPoint, "movie/upcoming")
        
        let urlString = endpointNowPlaying.pathBase + endpointNowPlaying.endPoint + endpointNowPlaying.apiKey
        guard let url = URL(string: urlString) else { return }
        let request = URLRequest(url: url)
        
        XCTAssertEqual(endpointNowPlaying.urlRequest, request)
        
        let urlImageString = endpointNowPlaying.imagePathBase + endpointNowPlaying.endPoint
        let urlImage = URL(string: urlString)
        
        XCTAssertEqual(endpointNowPlaying.imageUrl, urlImage)
        
    }
}
