//
//  FavoriteManagerTest.swift
//  BAZProjectTests
//
//  Created by Daniel Alberto Vazquez Rodriguez on 12/05/23.
//

import Foundation
import XCTest
import BAZProject

final class FavoriteManagerTest: XCTestCase {
    private var sut: FavoriteSavingManager!
    private var arrSaved: [Movie]?
    private var mockPersistence: MockPersistence!
    
    override func setUp() {
        super.setUp()
        mockPersistence = MockPersistence()
        sut = FavoriteSavingManager(persistence: mockPersistence)
        arrSaved = [Movie]()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        mockPersistence = nil
        arrSaved = nil
    }
    
    func testNotFavoriteMovieAdded() {
        //Given
        let movie = Movie(id: 1, title: "Un test", poster_path: "Kohane.jpg", overview: "Algo por aqui", release_date: "Una fecha")
        //When
        sut.handle(movie: movie, isFavorite: false)
        //Then
        XCTAssertTrue(sut.movieIsFavorite(movie))
    }
}
