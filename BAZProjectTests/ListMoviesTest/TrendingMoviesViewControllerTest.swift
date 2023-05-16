//
//  TrendingMoviesViewControllerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 25/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesViewControllerTest: XCTestCase {
    
    ///Sut
    private var sut: MoviesViewController!

    ///Fake Movie lis
    private var movies: [ListMovieProtocol]!
    
    ///Inicializador de las variables para las unit Test
    override func setUp() {
        super.setUp()
        
        movies = [Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)]
        
        let view: MoviesViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TrendingMoviesViewController") as! MoviesViewController
        
        sut = view
        
       
    }
    
    ///Se  alimina la instancia de las variables para el test
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    ///Test que evalua que la lista de peliculas se actualiza correctamente
    func test_loadData_callsInteractor() {
        sut.loadData(movies: movies)
        sut.loadView()
        XCTAssertEqual(sut.movies.count, movies.count)
        
    }
    
    ///Test que evalua que la lista de peliculas se actualiza correctamente
    func test_loadSearchData() {
        sut.loadSearchData(movies: movies)
        sut.loadView()
        XCTAssertEqual(sut.searchResultMovies.count, movies.count)
        
    }
    
    

}
