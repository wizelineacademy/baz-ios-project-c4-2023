//
//  TrendingViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by gescarcega on 20/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingViewModelTests: XCTestCase {
    
    var sut: TrendingMoviesViewModel!
    var remoteData: TrendingRemoteDataMock!
    
    override func setUp() {
        super.setUp()
        remoteData = TrendingRemoteDataMock()
        sut = TrendingMoviesViewModel(remoteData: remoteData)
    }
    
    override func tearDown() {
        remoteData = nil
        sut = nil
        super.tearDown()
    }
    
    func test_GetMovies_MoviesCountShouldBeThree() {
        let movies = [Movie(title: "title1"), Movie(title: "title2"), Movie(title: "title3")]
        let expectation = XCTestExpectation()
        
        sut.movies.bind {
            expectation.fulfill()
        }
        remoteData.movies = movies
        sut.getMovies()
        wait(for: [expectation], timeout: 0.1)
        let actualValue = sut.getRowCount()
        
        XCTAssertEqual(movies.count, actualValue)
    }
    
    func test_SearchMovies_MoviesCountShouldBeTwo() {
        let movies = [Movie(title: "title1"), Movie(title: "title2")]
        let expectation = XCTestExpectation()
        
        sut.movies.bind {
            expectation.fulfill()
        }
        remoteData.movies = movies
        sut.searchMovies("Text")
        wait(for: [expectation], timeout: 0.1)
        let actualValue = sut.getRowCount()
        
        XCTAssertEqual(movies.count, actualValue)
    }
    
    func test_GetMovies_Error() {
        let error = NSError(domain: "", code: -666)
        let expectation = XCTestExpectation()
        
        sut.error.bind {
            expectation.fulfill()
        }
        remoteData.error = error
        sut.getMovies()
        wait(for: [expectation], timeout: 0.1)
        let actualValue = sut.getError()
        
        XCTAssertNotNil(actualValue)
    }
    
    func test_SearchMovies_Error() {
        let error = NSError(domain: "", code: -666)
        let expectation = XCTestExpectation()
        
        sut.error.bind {
            expectation.fulfill()
        }
        remoteData.error = error
        sut.searchMovies("")
        wait(for: [expectation], timeout: 0.1)
        let actualValue = sut.getError()
        
        XCTAssertNotNil(actualValue)
    }
    
    func test_GetMovies_MoviesCountShouldBeZeroByNilData() {
        let expectation = XCTestExpectation()
        
        sut.movies.bind {
            expectation.fulfill()
        }
        sut.getMovies()
        wait(for: [expectation], timeout: 0.1)
        let actualValue = sut.getRowCount()
        
        XCTAssertEqual(0, actualValue)
    }
    
    func test_SearchMovies_MoviesCountShouldBeZeroByNilData() {
        let expectation = XCTestExpectation()
        
        sut.movies.bind {
            expectation.fulfill()
        }
        sut.searchMovies("Text")
        wait(for: [expectation], timeout: 0.1)
        let actualValue = sut.getRowCount()
        
        XCTAssertEqual(0, actualValue)
    }
    
    func test_MoviesCountShouldBeZeroByNilData() {
        let expectation = XCTestExpectation()
        
        sut.movies.bind {
            expectation.fulfill()
        }
        sut.getMovies()
        wait(for: [expectation], timeout: 0.1)
        let actualValue = sut.getRowCount()
        
        XCTAssertEqual(0, actualValue)
    }
}
