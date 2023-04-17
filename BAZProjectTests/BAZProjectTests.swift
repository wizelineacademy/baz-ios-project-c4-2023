//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 30/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {

    private var sut: MoviesViewModels!
    private var serviceMock: ServiceMock!
    private var sessionMock: URLSessionMock!
    private var Results: [Movie]?
   
    
    override func setUp() {
        super.setUp()
        sessionMock = URLSessionMock()
        serviceMock = ServiceMock(sessionMock: sessionMock)
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        sessionMock = nil
        sessionMock = nil
    }
    
        
    func testGetMovie_Has_Information() {
        serviceMock.getMovies(Endpoint.getMovies){ (result: Result< [Movie], Error>) in
                switch result {
                case .success(let moviesReponse):
                    XCTAssertNotNil(moviesReponse)
                case .failure(_):
                    XCTFail("noData")
            }
        }
    }
}
