//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 28/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {

    private var sut: ServiceMocks!
    private var sessionMock = URLSessionMock()
    
    override func setUp() {
        super.setUp()
        sut = ServiceMocks(sessionMock: sessionMock)
    }

    override func tearDown() {
        sut = nil
    }
    
    func testGetApiMovie_Has_Information(){
        sut.getMovies(.getMovieDay){ (result: Result< [Movie], Error>) in
            switch result {
            case .success(let moviesReponse):
                XCTAssertNotNil(moviesReponse)
            case .failure(_):
                XCTFail("error.....")
            }
        }
    }

}
