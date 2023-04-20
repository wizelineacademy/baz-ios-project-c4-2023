//
//  SearchMoviesRouterTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 20/04/23.
//

import XCTest
@testable import BAZProject

final class SearchMoviesRouterTest: XCTestCase {
    
    private var sut : SearchMoviesRouterProtocol!

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = SearchMoviesRouter()
        super.setUp()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        super.tearDown()
    }
    
    func test_PresentNotEmptyAlert() {
        XCTAssertNotNil(sut.presentAlert(CWAlert.simpleWith(message: "mensaje")))
    }
    
    func test_PresentValidMessageAlet(){
        //Given
        let expected = "Hola"
        //when
        let msg = CWAlert.simpleWith(message: "Hola")
        //Then
        XCTAssertEqual(expected, msg.message ?? "")
    }
    
    func test_Validate_ViewIsNil(){
        XCTAssertNil(sut.view)
    }

}
