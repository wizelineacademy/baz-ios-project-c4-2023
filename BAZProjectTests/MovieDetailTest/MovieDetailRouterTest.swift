//
//  MovieDetailRouterTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import XCTest
@testable import BAZProject

final class MovieDetailRouterTest: XCTestCase {
    
    ///Sut
    var sut: MovieDetailRouter!
    
    ///Fake movie
    private var movies: ListMovieProtocol!
    
    ///Inicializador de las variables para las unit Test
    override func setUp() {
        sut = MovieDetailRouter()
        movies = Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)
    }
    
    ///Se  alimina la instancia de las variables para el test
    override func tearDown() {
        sut = nil
    }
    
    ///Test que evalua que se crea el modulo Viper correctamente 
    func test_createModule_returnViewcontroller(){
        XCTAssertNotNil(MovieDetailRouter.createModule(movie: movies))
    }
}
