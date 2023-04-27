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
    var movie: ImageTextTableViewProtocol?
    var testMovie: Movie!
    
    override func setUp() {
        super.setUp()
        sut = DetailInteractor()
        sut?.presenter = self
        testMovie = Movie(id: 1, title: "Prueba de inyección", poster_path: "/Kohane.jpg", overview: "No hay", release_date: "2023-12-14")
        sut?.setUpEntity(withMovie: testMovie)
        
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        testMovie = nil
    }
    
    func testMovieIsSentToPresenter() {
        //When
        sut?.getCurrentData()
        //Then
        XCTAssertEqual(self.testMovie.title, self.movie?.strTitle)
    }
}

extension DetailInteractorTest: DetailPresentationLogic {
    func currentInfo(movie: ImageTextTableViewProtocol?) {
        self.movie = movie
    }
}
