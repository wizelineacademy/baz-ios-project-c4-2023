//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by Carlos Garcia on 07/04/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {
    
    var sut: HomeInteractor!
    var mock: MockPresenter!
    var api: MovieAPI!
    
    override func setUp() {
        super.setUp()
        sut = HomeInteractor()
        mock = MockPresenter()
        api = MovieAPI()
        sut.presenter = mock
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        api = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInteractor_getSectionDataGreaterThanZero_updateSectionData() throws {
        sut.setSectionsData()
        let arrSections = mock.arrSections
        XCTAssertGreaterThan(arrSections.count, 0)
    }
    
    func testAPI_getTrendingMoviesGreaterThanZero_showMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        api.getTrendingMovies { movies in
            XCTAssertGreaterThan(movies?.count ?? 0, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAPI_getNowPlayingMoviesGreaterThanZero_showMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        api.getNowPlayingMovies { movies in
            XCTAssertGreaterThan(movies?.count ?? 0, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAPI_getPopularMoviesGreaterThanZero_showMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        api.getPopularMovies { movies in
            XCTAssertGreaterThan(movies?.count ?? 0, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAPI_getMoviesFoundNotNil_showMovies() throws {
        api.searchMoviesfor(keyword: "matrix") { movies in
            XCTAssertNotNil(movies)
        }
    }
    
    func testAPI_getMoviesFoundGreaterThanZero_showMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        api.searchMoviesfor(keyword: "matrix") { movies in
            XCTAssertGreaterThan(movies?.count ?? 0, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testResourse_getImageCoverNotNil_showCoverImage() throws {
        let path: String = "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg"
        ResourcesManager().downloadImage(from: path) { image in
            XCTAssertNotNil(image)
        }
    }
    
    func testMovieDetails_getMovieNotNil_showMovieInfo() throws {
        let movieID = 361743
        api.searchMovieDetails(for: movieID) { movie in
            XCTAssertNotNil(movie)
        }
    }
    
    func testMovieReviews_getMovieReviewsGreaterThanZero_showReviews() throws {
        let movieID = 361743
        api.searchMovieReviews(for: movieID) { credits, error  in
            XCTAssertGreaterThan(credits?.count ?? 0, 0)
        }
    }
    

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

class MockPresenter: HomeInteractorOutputProtocol {
    var arrSections: [MovieSection] = []
    var arrMoviesFound: [MovieFoundInfo]?
    
    func updateSectionsData(_ sectionData: [MovieSection]) {
        arrSections = sectionData
    }
    
    func updateMovies(_ movies: [MovieInfo]?, in section: Int) {
        guard let movies = movies else {
            return
        }
        arrSections[section].movies = movies
    }
    
    func updateMoviesFound(_ movies: [MovieFoundInfo]?) {
        arrMoviesFound = movies
    }
}
