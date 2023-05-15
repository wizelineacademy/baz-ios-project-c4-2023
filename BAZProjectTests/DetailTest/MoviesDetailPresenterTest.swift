//
//  MoviesDetailPresenterTest.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 06/05/23.
//

import XCTest
@testable import BAZProject

final class MoviesDetailPresenterTest: XCTestCase {
    
    private var sut: MoviesDetailPresenter?
    var presenter: BAZProject.MoviesDetailViewOutputProtocol?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        sut = MoviesDetailPresenter()
        sut?.view = self
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        sut = nil
    }
    
    func test_NotNil_Presenter(){
        XCTAssertNotNil(sut?.setError())
        XCTAssertNotNil(sut?.showBtnFavorites(with: true))
        XCTAssertNotNil(sut?.addMovieToFavorite())
        XCTAssertNotNil(sut?.getInfoFavoritesMovies())
        XCTAssertNotNil(sut?.setResponseDetailsMovies(with: [ReviewsMovieData]()))
        XCTAssertNotNil(sut?.setResponseDetail(with: [InfoDetailData](), detail: .Similars))
    }
    
    func test_MoviesHasZeroElements(){
        //Given
        let expected = 0
        //When
        let countMovies = sut?.resultReviews.count ?? 0
        //Then
        XCTAssertEqual(expected, countMovies)
    }
    
}
extension MoviesDetailPresenterTest: MoviesDetailViewInputProtocol{
    func setInfoMovie(with movieData: BAZProject.MovieData?) {
        
    }
    
    func setReviews() {
        
    }
    
    func setRecomendations() {
        
    }
    
    func setSimilars() {
        
    }
    
    func setBtnLike(bsIsOn: Bool) {
        
    }
    
    
}
