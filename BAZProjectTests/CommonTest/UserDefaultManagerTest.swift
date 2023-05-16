//
//  UserDefaultManagerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 13/05/23.
//

import XCTest

@testable import BAZProject

///clase que implementa los test para UserDefaultManagerTest
final class UserDefaultManagerTest: XCTestCase {
    
    ///Sut
    private var sut: UserDefaultManager!
    
    ///UserDefaultManager Fake
    private var fakeUserDefault: UserDefaultsFake!
    
    ///Movie para crear el arreglo 
    private var movie = Movie(id: 123456, title: "Ejmplo", posterPath: "Ejmplo", adult: false, genreIDS: [], originalLanguage: "Ejmplo", originalTitle: "Ejmplo", overview: "Ejmplo", popularity: 1.0, releaseDate: "Ejmplo", video: false, voteAverage: 1.0, voteCount: 1)

    ///Inicializador de las variables para las unit Test
    override func setUp() {
        super.setUp()
        fakeUserDefault = UserDefaultsFake(fakeMoview: [1234 : movie])
        sut = UserDefaultManager(userDefault: fakeUserDefault)
        
    }
    
    ///Se  alimina la instancia de las variables para el test
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeUserDefault = nil
        movie = nil
    }
    
    ///Test que evalua si el metodo isFavorite regresa una pelicula
    func test_isFavorite_returnBool() {
        let isFavorite = sut.isFavorite(id: 1234)
        XCTAssertTrue(isFavorite)
    }
    
    ///Test que evalua si el metodo getFavorite regresa una pelicula favorita
    func test_getFavorite_returnMoview() {
        let sutMovie = sut.getFavorite(id: 1234)
        XCTAssertNotNil(sutMovie)
    }
    
    ///Test que evalua si el metodo getFavoriteList regresa una lista  pelicula
    func test_getFavoriteList_returnArrayMovies(){
        let sutMovies = sut.getFavoriteList()
        XCTAssertNotNil(sutMovies)
    }
    
    ///Test que evalua si el metodo saveFavorite guarda una movie
    func test_saveFavorite(){
        sut.saveFavorite(movie: movie)
        XCTAssertEqual(fakeUserDefault.fakeMoview, [1234 : movie])
    }
     
    ///Test que evalua si el metodo deleteDicitonay actualiza el diccionario de favoritos 
    func test_deleteDicitonay(){
        sut.deleteFavorite(1234)
        fakeUserDefault.fakeMoview = nil
        XCTAssertNil(sut.getFavorite(id: 1234))
    }

    
}
