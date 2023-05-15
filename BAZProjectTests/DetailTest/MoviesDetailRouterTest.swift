//
//  MoviesDetailRouterTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 05/05/23.
//

import XCTest
@testable import BAZProject

final class MoviesDetailRouterTest: XCTestCase {

    private var sut : MoviesDetailRouterProtocol!
    let movies: MovieData? = nil 
    

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = MoviesDetailRouter()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    // MARK: Test - View
    // Validate View is not nil
    func test_Validate_ViewIsNil(){
        XCTAssertNil(sut.view)
    }
    
    func test_createModule_NotNil() {
        //When
        let module = MoviesDetailRouter.createModule(with: movies)
        
        // then
        XCTAssertNotNil(module)
        XCTAssertNotNil(module.view)
    }

}
