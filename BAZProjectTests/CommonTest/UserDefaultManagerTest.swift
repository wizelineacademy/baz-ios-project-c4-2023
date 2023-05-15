//
//  UserDefaultManagerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 13/05/23.
//

import XCTest

@testable import BAZProject

final class UserDefaultManagerTest: XCTestCase {
    
    private var sut: UserDefaultManager!
    private var fakeUserDefault: UserDefaultsFake!
    private var movie = Movie(id: 123456, title: "Ejmplo", posterPath: "Ejmplo", adult: false, genreIDS: [], originalLanguage: "Ejmplo", originalTitle: "Ejmplo", overview: "Ejmplo", popularity: 1.0, releaseDate: "Ejmplo", video: false, voteAverage: 1.0, voteCount: 1)

    override func setUp() {
        super.setUp()
        fakeUserDefault = UserDefaultsFake(fakeMoview: [1234 : movie])
        sut = UserDefaultManager(userDefault: fakeUserDefault)
        
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func test_isFavorite_returnBool() {
        let isFavorite = sut.isFavorite(id: 1234)
        XCTAssertTrue(isFavorite)
    }
    
    func test_getFavorite_returnMoview() {
        let sutMovie = sut.getFavorite(id: 1234)
        XCTAssertNotNil(sutMovie)
    }
    
    func test_getFavoriteList_returnArrayMovies(){
        let sutMovies = sut.getFavoriteList()
        XCTAssertNotNil(sutMovies)
    }
    
    func test_saveFavorite(){
        sut.saveFavorite(movie: movie)
        XCTAssertEqual(fakeUserDefault.fakeMoview, [1234 : movie])
    }
     
    func test_deleteDicitonay(){
        sut.deleteFavorite(1234)
        fakeUserDefault.fakeMoview = nil
        XCTAssertNil(sut.getFavorite(id: 1234))
    }

    
}
