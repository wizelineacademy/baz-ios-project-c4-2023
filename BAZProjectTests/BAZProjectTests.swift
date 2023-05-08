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
    var favManager: FavouriteManager!
    var imageLoader: ImageLoader!
    
    override func setUp() {
        super.setUp()
        favManager = FavouriteManager()
        movieApi = MovieAPI()
        imageLoader = ImageLoader()
        interactor = HomeInteractor(movieAPI: movieApi, favouriteManager: favManager)
        let storyboard = UIStoryboard(name: "HomeMovies", bundle: nil)
        view = (storyboard.instantiateViewController(withIdentifier: "HomeMovies") as? HomeViewController)
        view.loadViewIfNeeded()
        router = HomeRouter()
        presenter = HomePresenter(view: view, interactor: interactor, router: router)
        interactor?.presenter = presenter
        view.movies = getMockPopularMovies()
        view.populars = getMockPopularMovies()
        view.cineMovies = getMockPopularMovies()
        view.topMovies = getMockPopularMovies()
        view.upcomingMovies = getMockPopularMovies()
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
        presenter.pushSearchViewController(view: view)
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
        let expectation = self.expectation(description: "Data fetched successfully")
        let urlExpected = URL(string: "https://image.tmdb.org/t/p/w500/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg")
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = view.collectionView(view.moviesCollectionView, cellForItemAt: indexPath) as? MoviesCollectionViewCell
        XCTAssertEqual(urlExpected, imageLoader?.getURLImage(poster_path: view.movies[1].poster_path ?? ""))
        XCTAssertNotNil(imageLoader?.getURLImage(poster_path: view.movies[1].poster_path ?? ""))
        guard let urlMovieImage = imageLoader?.getURLImage(poster_path: view.movies[1].poster_path ?? "") else {
            XCTAssertNil(imageLoader?.getURLImage(poster_path: view.movies[1].poster_path ?? ""))
            return
        }
        imageLoader.loadImage(urlData: urlMovieImage) { image in
            XCTAssertNotNil(cell?.movieImage)
            XCTAssertNotNil(self.view.moviesCollectionView.numberOfSections)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 20) { error in
                if let error = error {
                    XCTFail("Failed with error: \(error)")
                }
            }
    }
    // Test collection view sections
    func testNumberOfSections() {
        // Verify that the table view has one section
        XCTAssertEqual(view.moviesCollectionView.numberOfSections , 5)
    }
    // Test number of rows at section in a collection view
    func testNumberOfRowsInSection() {
        // Verify that the table view has three rows in the first section
        XCTAssertEqual(view.collectionView(view.moviesCollectionView, numberOfItemsInSection: view.movies.count), 0)
        XCTAssertEqual(view.collectionView(view.moviesCollectionView, numberOfItemsInSection: view.populars.count), 0)
        XCTAssertEqual(view.collectionView(view.moviesCollectionView, numberOfItemsInSection: view.cineMovies.count), 0)
        XCTAssertEqual(view.collectionView(view.moviesCollectionView, numberOfItemsInSection: view.topMovies.count), 0)
        XCTAssertEqual(view.collectionView(view.moviesCollectionView, numberOfItemsInSection: view.upcomingMovies.count), 0)
        presenter.fetchCategories(url: "trending/movie/day?api_key", section: 0)
        presenter.fetchCategories(url: "movie/popular?api_key=", section: 1)
        presenter.fetchCategories(url: "movie/now_playing?api_key=", section: 2)
        presenter.fetchCategories(url: "movie/top_rated?api_key=", section: 3)
        presenter.fetchCategories(url: "movie/upcoming?api_key=", section: 4)
        XCTAssertNotNil(view.showCategories(movies: view.movies, section: 0))
        XCTAssertNotNil(view.showCategories(movies: view.populars, section: 1))
        XCTAssertNotNil(view.showCategories(movies: view.cineMovies, section: 2))
        XCTAssertNotNil(view.showCategories(movies: view.cineMovies, section: 3))
        XCTAssertNotNil(view.showCategories(movies: view.cineMovies, section: 4))
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
        XCTAssertNotNil(cell3?.movieImage)
        let indexPath4 = IndexPath(row: 0, section: 3)
        let cell4 = view.collectionView(view.moviesCollectionView, cellForItemAt: indexPath4) as? MoviesCollectionViewCell
        XCTAssertNotNil(cell4?.movieImage)
        let indexPath5 = IndexPath(row: 0, section: 4)
        let cell5 = view.collectionView(view.moviesCollectionView, cellForItemAt: indexPath5) as? MoviesCollectionViewCell
        XCTAssertNotNil(cell5?.movieImage)
        let indexPath6 = IndexPath(row: 0, section: 0)
        let cell6 = view.collectionView(view.categoriesMenuCollection, cellForItemAt: indexPath6) as? CategoriesMenuCollectionViewCell
        XCTAssertNotNil(cell6?.categoriesLabel)
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
        presenter.presenterCategories(movies: view.populars, section: 1)
        presenter.presenterCategories(movies: view.cineMovies, section: 2)
        presenter.presenterCategories(movies: view.topMovies, section: 2)
        presenter.presenterCategories(movies: view.upcomingMovies, section: 2)
        XCTAssertNotNil(view.moviesCollectionView)
        
    }
    // test when we have to push a VC
    func testPushVC() {
        let viewToPush = SearchMoviesRouter.createModule()
        XCTAssertNotNil(presenter.pushSearchViewController(view: viewToPush))
    }
    // test for create module of Favourites
    func testPushVCFavs() {
        let viewToPush = FavouriteMoviesRouter.createModule()
        XCTAssertNotNil(presenter.pushSearchViewController(view: viewToPush))
    }
    // test for create module of Review movies
    func testPushVCReview() {
        guard let movieToReview = getMockPopularMovies().first else {
            XCTAssertNil(getMockPopularMovies().first)
            return
        }
        let viewToPush = ReviewMoviesRouter.createModule(movieReview: movieToReview)
        XCTAssertNotNil(presenter.pushSearchViewController(view: viewToPush))
    }
    // test for set a movie in UserDefaults
    func testRegisterUserDefaults() {
        XCTAssertNotNil(view.upcomingMovies.first)
        guard let movieFav = view.upcomingMovies.first else {
            return
        }
        XCTAssertNotNil(presenter.storeFav(movieFav: movieFav))
        XCTAssertNotNil(presenter.storeFav(movieFav: movieFav))
    }
    // test to select any item in collectionView of categories titles
    func testSelectAnyItem() {
        let indexPath = IndexPath(row: 0, section: 1)
        view.collectionView(view.categoriesMenuCollection, didSelectItemAt: indexPath)
    }
    // test to select any item in collectionView of categories 
    func testSelectAnyItemCategories() {
        var indexPath = IndexPath(row: 0, section: 0)
        XCTAssertNotNil(view.collectionView(view.moviesCollectionView, didSelectItemAt: indexPath))
        indexPath.section = 1
        XCTAssertNotNil(view.collectionView(view.moviesCollectionView, didSelectItemAt: indexPath))
        indexPath.section = 2
        XCTAssertNotNil(view.collectionView(view.moviesCollectionView, didSelectItemAt: indexPath))
        indexPath.section = 3
        XCTAssertNotNil(view.collectionView(view.moviesCollectionView, didSelectItemAt: indexPath))
        indexPath.section = 4
        XCTAssertNotNil(view.collectionView(view.moviesCollectionView, didSelectItemAt: indexPath))
    }
    
    // Mock of popular movies
    func getMockPopularMovies() -> [Movie] {
        let popularMockMovies: [Movie] = [Movie(id: 100, title: "Avengers", poster_path: "path/avengers"),
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
