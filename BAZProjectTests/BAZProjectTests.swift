//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by Carlos Garcia on 07/04/23.
//

import XCTest

final class BAZProjectTests: XCTestCase {
    
    var sut: TrendingViewController!
    var api: MovieAPI!
    
    override func setUp() {
        super.setUp()
        sut = TrendingViewController()
        api = MovieAPI()
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

    func testAPI_MoviesResponseNotNil_UupdateMoviesArray() throws {
        api.getMovies { movies in
            XCTAssertNotNil(movies)
        }
    }
    
    func testAPI_getMoviesGreaterThanZero_showMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        api.getMovies { movies in
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
    
    

//    func testPerformanceExample() throws {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}
