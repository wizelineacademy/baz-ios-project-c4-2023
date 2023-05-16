//
//  MovieRouterTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 14/05/23.
//

import XCTest
@testable import BAZProject

final class MovieRouterTests: XCTestCase {
    
    var sut: MovieRouter!
    
    override func setUp() {
        sut = MovieRouter()
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_CreateModule(){
        XCTAssertNotNil(MovieRouter.createModule(endpoint: .recentsMovies))
    }
    
    func test_CreateModuleTopRated(){
        XCTAssertNotNil(MovieRouter.createModule(endpoint: .topRatedMovies))
    }
    
}
