//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by ksolano on 30/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {
    
    var interactor: HomeInteractor!
    var presenter: HomePresenter!
    var view: HomeViewController!
    var router: HomeRouter!
    var movieApi: MovieAPI!
    
    override func setUp() {
        super.setUp()
        movieApi = MovieAPI()
        interactor = HomeInteractor()
        let storyboard = UIStoryboard(name: "HomeMovies", bundle: nil)
        view = (storyboard.instantiateViewController(withIdentifier: "HomeMovies") as! HomeViewController)
        view.loadViewIfNeeded()
        router = HomeRouter()
        presenter = HomePresenter(view: view, interactor: interactor, router: router)
        interactor?.presenter = presenter
        view.movies = getMockPopularMovies()
        view.populars = getMockPopularMovies()
        view.cineMovie = getMockPopularMovies()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
        presenter = nil
    }
    
    // Test valid fecth movies from API
    func testMovies_fetchMovies_isNotNil() {
        // Given
        let expectedMovies = 20
        // When
        guard let urlFetch = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a") else {
            return
        }
        let urlRequestMovie = URLRequest(url: urlFetch)
        movieApi.fetch(urlRequest: urlRequestMovie) { (result: Result<MovieResult, NetworkError>) in
            // Then
            switch result {
            case .success(let movies):
                XCTAssertNotNil(movies.results)
                XCTAssertEqual(movies.results.count, expectedMovies)
            case .failure(let error):
                XCTFail("Login failed with error: \(error.localizedDescription)")
            }
        }
    }
    
    // test number of movies and not nil array for show
    func testMovies_isNotNil_countMovies() {
        // When
        interactor.fetchCategories(url: "trending/movie/day?api_key=", section: 0)
        interactor.fetchCategories(url: "movie/popular?api_key=", section: 1)
        interactor.fetchCategories(url: "movie/now_playing?api_key=", section: 2)
        // Then
        XCTAssertEqual(interactor.movies.count, 0)
    }
    // Test fecth Categories call view to presenter
    func testMovies_fetchCategories_callInteractor() {
        presenter.fetchCategories(url: "trending/movie/day?api_key=", section: 0)
        presenter.fetchCategories(url: "movie/popular?api_key=", section: 1)
        presenter.fetchCategories(url: "movie/now_playing?api_key=", section: 2)
        
        XCTAssertEqual(interactor.movies.count, 0)
    }
    // Test if movie can push a VC
    func testMovies_isVC_push() {
        XCTAssertNotNil(view)
        presenter.pushViewController(view: view)
    }
    // Test enum error when url is invalid
    func testEnumeError_BadUrl() {
        
        let networkError: NetworkError = .badURL
        XCTAssertNotNil(networkError)
        XCTAssertEqual(networkError.localizedDescription, "Error en la URL")
    }
    // Test enum error when user has bad network
    func testEnumeError_BadNetwork() {
        
        let networkError: NetworkError = .badNetwork
        XCTAssertNotNil(networkError)
        XCTAssertEqual(networkError.localizedDescription, "Revisa tu conexión")
    }
    // Test enum error when API don´t fetch with movie information
    func testEnumeErrorEmptyResult() {
        
        let networkError: NetworkError = .emptyResult
        XCTAssertNotNil(networkError)
        XCTAssertEqual(networkError.localizedDescription, "No hay resultado")
    }
    // Test get a valid URL for fetch
    func testGetURLImageValid(){
        let urlExpected = URL(string: "https://image.tmdb.org/t/p/w500/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg")
        XCTAssertEqual(urlExpected, view.getURLImage(poster_path: view.movies[1].poster_path ?? ""))
        
    }
    // Test collection view sections
    func testNumberOfSections() {
        // Verify that the table view has one section
        XCTAssertEqual(view.moviesCollectionView.numberOfSections , 3)
    }
    // Test number of rows at section in a collection view
    func testNumberOfRowsInSection() {
        // Verify that the table view has three rows in the first section
        XCTAssertEqual(view.collectionView(view.moviesCollectionView, numberOfItemsInSection: view.movies.count), 0)
        XCTAssertEqual(view.collectionView(view.moviesCollectionView, numberOfItemsInSection: view.populars.count), 0)
        XCTAssertEqual(view.collectionView(view.moviesCollectionView, numberOfItemsInSection: view.cineMovie.count), 0)
        
        presenter.fetchCategories(url: "trending/movie/day?api_key", section: 0)
        presenter.fetchCategories(url: "movie/popular?api_key=", section: 1)
        presenter.fetchCategories(url: "movie/now_playing?api_key=", section: 2)
        XCTAssertNotNil(view.showCategories(movies: view.movies, section: 0))
        XCTAssertNotNil(view.showCategories(movies: view.populars, section: 1))
        XCTAssertNotNil(view.showCategories(movies: view.cineMovie, section: 2))
        
    }
    // Test number of items in a section and informatión not nil
    func testCellForRow() {
        // Verify that the cell at row 0 has the correct text label
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = view.collectionView(view.moviesCollectionView, cellForItemAt: indexPath) as? MoviesCollectionViewCell
        XCTAssertNotNil(cell?.movieTitle.text)
        let indexPath2 = IndexPath(row: 0, section: 1)
        let cell2 = view.collectionView(view.moviesCollectionView, cellForItemAt: indexPath2) as? MoviesCollectionViewCell
        XCTAssertNotNil(cell?.movieTitle.text)
        let indexPath3 = IndexPath(row: 0, section: 2)
        let cell3 = view.collectionView(view.moviesCollectionView, cellForItemAt: indexPath3) as? MoviesCollectionViewCell
        XCTAssertNotNil(cell?.movieImage)
        XCTAssertNotNil(view.moviesCollectionView.numberOfSections)
        XCTAssertNotNil(cell2?.movieImage)
        XCTAssertNotNil(view.moviesCollectionView.numberOfSections)
        XCTAssertNotNil(cell3?.movieImage)
        XCTAssertNotNil(view.moviesCollectionView.numberOfSections)
    }
    // Test when section don´t have information to show
    func testNumberOfRowsInSectionWithoutMovies() {
        // Verify that the table view has three rows in the first section
        view.movies = []
        XCTAssertEqual(view.collectionView(view.moviesCollectionView, numberOfItemsInSection: 0), 0)
    }
    // Test Present category movies
    func testPresentMovieCategories() {
        presenter.presenterCategories(movies: view.movies, section: 0)
        presenter.presenterCategories(movies: view.movies, section: 1)
        presenter.presenterCategories(movies: view.movies, section: 2)
        XCTAssertNotNil(view.moviesCollectionView)
        
    }
    // test when we have to push a VC
    func testPushVC() {
        let viewToPush = SearchMoviesRouter.createModule()
        XCTAssertNotNil(presenter.pushViewController(view: viewToPush))
    }
    // Mock of popular movies
    func getMockPopularMovies() -> [MovieProtocol] {
        let popularMockMovies: [MovieProtocol] = [Movie(id: 100, title: "Avengers", poster_path: "path/avengers"),
                                              Movie(id: 1726, title: "Iron Man", poster_path: "/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg"),
                                              Movie(id: 101, title: "Batman", poster_path: "path/batman"),
                                              Movie(id: 155, title: "El caballero oscuro", poster_path: "/8QDQExnfNFOtabLDKqfDQuHDsIg.jpg"),
                                              Movie(id: 102, title: "Spiderman", poster_path: "path/spidermanNoWayHome"),
                                              Movie(id: 604, title: "Matrix Reloaded", poster_path: "/ayZkaN2f3ASjWW8ooCfuJT3T8Va.jpg"),
                                              Movie(id: 102, title: "Avengers", poster_path: "path/avengers"),
                                              Movie(id: 1728, title: "Iron Man", poster_path: "/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg"),
                                              Movie(id: 110, title: "Batman", poster_path: "path/batman"),
                                              Movie(id: 150, title: "El caballero oscuro", poster_path: "/8QDQExnfNFOtabLDKqfDQuHDsIg.jpg"),
                                              Movie(id: 132, title: "Spiderman", poster_path: "path/spidermanNoWayHome"),
                                              Movie(id: 644, title: "Matrix Reloaded", poster_path: "/ayZkaN2f3ASjWW8ooCfuJT3T8Va.jpg"),
                                              Movie(id: 144, title: "Avengers", poster_path: "path/avengers"),
                                              Movie(id: 1727, title: "Iron Man", poster_path: "/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg"),
                                              Movie(id: 109, title: "Batman", poster_path: "path/batman"),
                                              Movie(id: 105, title: "El caballero oscuro", poster_path: "/8QDQExnfNFOtabLDKqfDQuHDsIg.jpg"),
                                              Movie(id: 112, title: "Spiderman", poster_path: "path/spidermanNoWayHome"),
                                              Movie(id: 645, title: "Matrix Reloaded", poster_path: "/ayZkaN2f3ASjWW8ooCfuJT3T8Va.jpg")]
        return popularMockMovies
    }
    
}
