//
//  MovieDetailPresenterTests.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailPresenterTests: XCTestCase {
    
    var sut: (MovieDetailPresenterProtocol & MovieDetailInteractorOutputProtocol)?
    var interactorMock: DetailInteractorMock!
    var viewMock: MovieDetailViewMock!
    
    override func setUp() {
        super.setUp()
        sut = MovieDetailPresenter(movieId: 1)
        viewMock = MovieDetailViewMock()
        interactorMock = DetailInteractorMock()
        sut?.view = viewMock
        sut?.interactor = interactorMock
    }

    override func tearDown() {
       super.tearDown()
        sut = nil
        interactorMock = nil
    }
    
    func testNotifyViewLoaded() {
        // Given
        let result: [DetailInteractorMockCalls] = [.fetchMovieDetail]
        
        // When
        sut?.notifyViewLoaded()
        
        // Then
        XCTAssertEqual(interactorMock.detailCalls, result)
    }
    
    func testMoviesFetched() {
        // Given
        let expectation: XCTestExpectation = XCTestExpectation(description: "reloadData was called")
        viewMock.expectation = expectation
        
        // When
        sut?.movieDetailFetched(with: MovieDetail(id: 1, title: "Mario", overview: "Resume", popularity: 9.8, posterPath: "/wybmSmviUXxlBmX44gtpow5Y9TB.jpg", releaseDate: "2023-03-15", status: "movie"))
        
        // Then
        wait(for: [expectation], timeout: 0.1)
        XCTAssertEqual(sut?.movieDetail?.id, 1)
        XCTAssertTrue(viewMock.reloadDataWasCalled)
    }
    
    func testisNotFavorite(){
        let expect = false
        let isNotfavorite = sut?.isFavorite
        XCTAssertEqual(isNotfavorite, expect)
    }
    
    func testisFavorite(){
        let expect = true
        let isFavorite = sut?.isFavorite
        XCTAssertNotEqual(isFavorite, expect)
    }
    
    func testAddFavorites() {
        let expect = MovieFavorites.isSave(MovieFavorites())
        //let addfavorites = sut?.saveFavoriteMovie()
        XCTAssertNotNil(expect)
    }
    
    func testDeletetoFavorites(){
        XCTAssert(((sut?.deleteToFavoriteMovie()) != nil))
    }
    
    func testAddToFavorites2(){
        XCTAssert(((sut?.saveFavoriteMovie()) != nil))
    }
    
    func testDeleteFavorites(){
        let movieId: Int? = sut?.movieDetail?.id
        let expect = interactorMock.deleteToFavoriteMovie(of: movieId)
        XCTAssertNotNil(expect)
    }
    
    func testAddToFavorites() {
        let movieId = 1
        let expect = interactorMock.saveFavoriteMovie(of: movieId)
        XCTAssertNotNil(expect)
    }


}
