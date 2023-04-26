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
        guard let url = URL(string: ApiConstans.baseURL + ApiConstans.trending + ApiConstans.apiKey) else { return }
        sut.fetch(request: URLRequest(url: url)) {(result: Result<MovieResult?, Error>) in
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
        guard let url = URL(string: ApiConstans.baseURL + ApiConstans.trending + ApiConstans.apiKey) else { return }
        sut.fetch(request: URLRequest(url: url)) {(result: Result<MovieResult?, Error>) in
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
}
