//
//  TrendingInteractorTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 13/04/23.
//

import Foundation
import XCTest
import BAZProject

final class TrendingInteractorTest: XCTestCase {
    var sut: TrendingInteractor!
    private var errorThrown: ErrorApi?
    private var entity: TrendingEntity?
    private var mockServer: NetworkingProtocol?
    
    override func setUp() {
        super.setUp()
        sut = TrendingInteractor()
        entity = TrendingEntity()
        sut.presenter = self
        sut.entity = entity
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        errorThrown = nil
        entity = nil
        mockServer = nil
    }
    
    func testErrorIsCalledCorrectly() {
        //Given
        let errorExpected: ErrorApi = .badResponse
        //When
        mockServer = MockService<MovieService>(configuration: URLConfiguration(path: .noPath), caseToTest: .testError(.badResponse))
        sut.serviceApi = mockServer
        //Then
        sut.getMovies()
        XCTAssertEqual(errorExpected.getMessage(), errorThrown?.getMessage())
    }
    
    func testBadJsonIsCalledCorrectly() {
        //Given
        let errorExpected: ErrorApi = .badJSON
        //When
        mockServer = MockService<MovieService>(configuration: URLConfiguration(path: .noPath), caseToTest: .testError(.badJSON))
        sut.serviceApi = mockServer
        //Then
        sut.getMovies()
        XCTAssertEqual(errorExpected.getMessage(), errorThrown?.getMessage())
    }
    
    func testMoviesGotSuccessfully() {
        //Given
        let strFirstTitle = "¡Shazam! La furia de los dioses"
        //When
        mockServer = MockService<MovieService>(configuration: URLConfiguration(path: .noPath), caseToTest: .testSuccess("responseMock"))
        sut.serviceApi = mockServer
        //Then
        sut.getMovies()
        let strTitle = sut.getMovie(forRow: 0)?.title
        XCTAssertEqual(strFirstTitle, strTitle)
    }
    
    func testNumberOfRows() {
        //Given
        let iNumberExpected = 2
        //When
        mockServer = MockService<MovieService>(configuration: URLConfiguration(path: .noPath), caseToTest: .testSuccess("responseMock"))
        sut.serviceApi = mockServer
        //Then
        sut.getMovies()
        let iNumberGot = sut.getNumberOfRows()
        XCTAssertEqual(iNumberExpected, iNumberGot)
        
    }
}

extension TrendingInteractorTest: TrendingInteractorOutputProtocol {
    func serviceRespondedSuccess() {
        errorThrown = nil
    }
    
    func serviceFailed(withError error: ErrorApi) {
        errorThrown = error
    }
}
