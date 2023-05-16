//
//  MovieDetailRouterTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 14/05/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailRouterTests: XCTestCase {

    var sut: MovieDetailRouter!
    
    override func setUp() {
        sut = MovieDetailRouter()
        let movies = MovieDetail(id: 1, title: "Marip", overview: "Ejemplo", popularity: 10.0, posterPath: "ejemplo.jpg", releaseDate: "Ejemplo2", status: "ejemplo")
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_CreateModule(){
        XCTAssertNotNil(MovieDetailRouter.createMovieDetailModule(of: 1))
    }
    
}
