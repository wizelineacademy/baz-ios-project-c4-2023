//
//  TrendingMoviesInteractorTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesInteractorTest: XCTestCase {
    
    ///Sut
    private var sut: MoviesInteractor!
    
    ///Fake Movie Api
    private var fakeMovieApi: FakeMovieApi!
    
    ///Fake presenter
    private var presenter: MoviesPresenterMock!
    
    ///Fake moview
    var movie: Movie = Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)
    
    ///Inicializador de las variables para las unit Test
    override func setUp() {
        super.setUp()
        fakeMovieApi = FakeMovieApi(resultType: .sucess)
        presenter = MoviesPresenterMock(router: MoviesRouter())
        sut = MoviesInteractor(movieAPI: fakeMovieApi)
        sut.presenter = presenter
    }
    
    ///Se  alimina la instancia de las variables para el test
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovieApi = nil
        presenter = nil
    }
    
    ///Test que evalua que el metodo Similiar_result  del interactor envie la informacion al presenter
    func test_getMovies_callsApiAndSendInfo(){
        guard let request = MovieCategories.topRated.urlRequest else { return }
        sut.getMovies(urlRequest: request)
        presenter?.getMovies()
        XCTAssertEqual(presenter.calls, [.getMovies])
    }
    

    ///Test que evalua que el metodo findMovies  del interactor envie la informacion al presenter
    func test_findMovies_returnsMovies(){
        let searchText = "TextToSearch"
        sut.findMovies(for: searchText)
        presenter?.setMovies(result: [movie])
        XCTAssertEqual(presenter.calls, [.setMovies])
    }
    

}
