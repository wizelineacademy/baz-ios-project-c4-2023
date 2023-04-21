//
//  SearchMoviesInteractorTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 19/04/23.
//

import Foundation
import XCTest
@testable import BAZProject

final class SearchMoviesInteractorTest: XCTestCase{
    
    var presenter   : BAZProject.SearchMoviesInteractorOutputProtocol?
    var sut         : SearchMoviesInteractor!
    
    override func setUp() {
        super.setUp()
        sut = SearchMoviesInteractor(movieApi: MovieAPI(session: URLSession.shared))
    }
    
    override func tearDown()  {
        super.tearDown()
        sut = nil
    }
    
    func testSearchServiceBlock(){
        XCTAssertNotNil(sut.consultServiceSearch(with: "hola"))
    }
    
    func consultServiceSearch(with word: String) {
        sut.consultServiceSearch(with: word)
    }
    
}
