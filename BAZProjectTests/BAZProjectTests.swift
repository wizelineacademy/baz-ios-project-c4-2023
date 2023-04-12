//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by bvelazquezva on 29/03/23.
//

import XCTest
@testable import BAZProject

class BAZProjectTests: XCTestCase {
    
    var ApiMock: MovieApiMock?
    

    override func setUp(){
        super.setUp()
        ApiMock = MovieApiMock()
    }

    override func tearDown(){
        super.tearDown()
        ApiMock = nil
    }

    func test_DataMovieResponse(){
        //Give
        var expetationMovies: [Movie] = []
        ApiMock?.getMovies(completion: { movies in
            expetationMovies = movies
        })
        //When
        var result: [Movie] = []
        let realApi = MovieApi()
        realApi.getMovies { movies in
            result = movies
        }
        //Then
        XCTAssertEqual(expetationMovies, result)
    }
    
    func test_Data_NotNil(){
        //Give
        //When
        var result: [Movie] = []
        let realApi = MovieApi()
        realApi.getMovies { movies in
            result = movies
        }
        //Then
        XCTAssertNotNil(result)
    }

}


/*func test_DataMovie(){
    //Give
    //When
    //Then
}*/
