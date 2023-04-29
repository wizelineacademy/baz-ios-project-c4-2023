//
//  DetailInteractorTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 26/04/23.
//

import Foundation
import XCTest
import BAZProject

final class DetailInteractorTest: XCTestCase {
    var sut: DetailInteractor?
    var view: BAZProject.DetailSearchDisplayLogic?
    var movie: CellPersonalizedTableViewProtocol?
    var testMovie: Movie!
    private var mockServer: NetworkingProtocol?
    private var errorService: ErrorApi?
    private var arrSimilar: [CellPersonalizedTableViewProtocol]?
    private var arrReviews: [CellPersonalizedTableViewProtocol]?
    
    override func setUp() {
        super.setUp()
        sut = DetailInteractor()
        sut?.presenter = self
        testMovie = Movie(id: 1, title: "Prueba de inyección", poster_path: "/Kohane.jpg", overview: "No hay", release_date: "2023-12-14")
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        testMovie = nil
        errorService = nil
        arrSimilar = nil
    }
    
    func testMovieIsSentToPresenter() {
        //When
        sut?.setUpEntity(withMovie: testMovie)
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(self.testMovie.title, self.movie?.strTitle)
    }
    
    func testWhenMovieNilThrowsError() {
        //Given
        let errorExpected = ErrorApi.badParameter
        //When
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(errorExpected, errorService)
    }
    
    func testBadResponse() {
        //Given
        let erroExpected: ErrorApi = .badResponse
        sut?.setUpEntity(withMovie: testMovie)
        mockServer = MockService(configuration: URLConfiguration(path: .noPath), caseToTest: .testError(.badResponse))
        sut?.networking = mockServer
        //When
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(erroExpected, errorService)
    }
    
    func testSuccessfullVoidResponse() {
        //Given
        let iTotalResult = 0
        sut?.setUpEntity(withMovie: testMovie)
        mockServer = MockService(configuration: URLConfiguration(path: .noPath), caseToTest: .testSuccess("searchVoid"))
        sut?.networking = mockServer
        //When
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(arrSimilar?.count, iTotalResult)
    }
    
    func testSucessfullResponseWithResults() {
        //Given
        let iTotalExpected = 4
        sut?.setUpEntity(withMovie: testMovie)
        mockServer = MockService(configuration: URLConfiguration(path: .noPath), caseToTest: .testSuccess("similarMock"))
        sut?.networking = mockServer
        //When
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(arrSimilar?.count, iTotalExpected)
    }
    
    func testReviewNilError() {
        //Given
        let errorExpected = ErrorApi.badParameter
        //When
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(errorExpected, errorService)
    }
    
    func testReviewBadResponse() {
        //Given
        let erroExpected: ErrorApi = .badResponse
        sut?.setUpEntity(withMovie: testMovie)
        mockServer = MockService(configuration: URLConfiguration(path: .noPath), caseToTest: .testError(.badResponse))
        sut?.networking = mockServer
        //When
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(erroExpected, errorService)
    }
    
    func testReviewSuccessfullVoidResponse() {
        //Given
        let iTotalResult = 0
        sut?.setUpEntity(withMovie: testMovie)
        mockServer = MockService(configuration: URLConfiguration(path: .noPath), caseToTest: .testSuccess("searchVoid"))
        sut?.networking = mockServer
        //When
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(arrReviews?.count, iTotalResult)
    }
    
    func testReviewSucessfullResponseWithResults() {
        //Given
        let iTotalExpected = 1
        sut?.setUpEntity(withMovie: testMovie)
        mockServer = MockService(configuration: URLConfiguration(path: .noPath), caseToTest: .testSuccess("review"))
        sut?.networking = mockServer
        //When
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(arrReviews?.count, iTotalExpected)
    }
}

extension DetailInteractorTest: DetailPresentationLogic {
    func currentInfo(movie: CellPersonalizedTableViewProtocol?) {
        self.movie = movie
    }
    
    func serviceDidFailed(with error: ErrorApi) {
        errorService = error
    }
    
    func similarMoviewsObtained(with result: [CellPersonalizedTableViewProtocol]?) {
        arrSimilar = result
    }
    
    func reviewsWereObtained(with arrReviews: [CellPersonalizedTableViewProtocol]?) {
        self.arrReviews = arrReviews
    }
}
