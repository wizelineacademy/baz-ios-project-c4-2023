//
//  TrendingMoviesInteractorTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 24/04/23.
//

import XCTest
@testable import BAZProject

final class TrendingMoviesInteractorTest: XCTestCase {

    private var sut: MoviesInteractor!
    private var fakeMovieApi: FakeMovieApi!
    private var presenter: MoviesPresenterMock!
    var movie: Movie = Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)
    
    override func setUp() {
        super.setUp()
        fakeMovieApi = FakeMovieApi(resultType: .sucess)
        presenter = MoviesPresenterMock(router: MoviesRouter())
        sut = MoviesInteractor(movieAPI: fakeMovieApi)
        sut.presenter = presenter
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
        fakeMovieApi = nil
        presenter = nil
    }
    
    func test_getMovies_callsApiAndSendInfo(){
        guard let request = MovieCategories.topRated.urlRequest else { return }
        sut.getMovies(urlRequest: request)
        presenter?.getMovies()
        XCTAssertEqual(presenter.calls, [.getMovies])
    }
    
    
    func test_findMovies_returnsMovies(){
        let searchText = "TextToSearch"
        sut.findMovies(for: searchText)
        presenter?.setMovies(result: [movie])
        XCTAssertEqual(presenter.calls, [.setMovies])
    }
    

}
