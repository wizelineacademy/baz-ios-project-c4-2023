//
//  SearchTests.swift
//  BAZProjectTests
//
//  Created by ksolano on 21/04/23.
//

import XCTest
@testable import BAZProject

final class SearchTests: XCTestCase {
    
    var interactor: SearchMoviesInteractor!
    var presenter: SearchMoviesPresenter!
    var view: SearchMoviesViewController!
    var router: SearchMoviesRouter!
    var movieApi: MovieAPI!
    
    override func setUp() {
        super.setUp()
        movieApi = MovieAPI()
        interactor = SearchMoviesInteractor()
        let storyboard = UIStoryboard(name: "SearchMovies", bundle: nil)
        view = (storyboard.instantiateViewController(withIdentifier: "SearchStory") as! SearchMoviesViewController)
        view.loadViewIfNeeded()
        router = SearchMoviesRouter()
        presenter = SearchMoviesPresenter(view: view, interactor: interactor, router: router)
        interactor?.presenter = presenter
        view.movies = getMockPopularMovies()
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
        presenter = nil
    }
    // Test when we don´t have information
    func testMovies_isNotNil_countMovies() {
        // Given
        // When
        interactor.searchMovies(url: "trending/movie/day?api_key=", key: "")
        // Then
        XCTAssertEqual(interactor.movies.count, 0)
    }
    // Testing search movies
    func testSearchAnyMovie() {
        func testMovies_fetchCategories_callInteractor() {
            presenter.searchMovies(url: "trending/movie/day?api_key=", key: "&language=es&query=Avengers")
            XCTAssertEqual(interactor.movies.count, 0)
        }
    }
    // Test the init of the table an register
    func testInitTableOfSearch() {
        XCTAssertNotNil(view.registerTable())
    }
    // Test movieFecth for init the view with all the movies
    func testGetPrincipalMovies() {
        XCTAssertNotNil(view.movieFecth())
    }
    // Testing when user want to pop a VC
    func testPopViewControllerIsValid() {
        XCTAssertNotNil(presenter.popViewController())
    }
    // Test for get a url image from a poster_path returned of the fetch
    func testgetUrlImageForShow()  {
        let urlExpected = URL(string: "")
        let urlImage = view.getURLImage(poster_path: "")
        XCTAssertNotNil(urlImage)
        XCTAssertNotEqual(urlExpected, urlImage)
    }
    // Test and verify sections in a Table view
    func testNumberOfSections() {
        // Verify that the table view has one section
        XCTAssertEqual(view.searchTableView.numberOfSections , 1)
    }
    // Test number of rows in a tble view when has a fecth movies
    func testNumberOfRowsInSection() {
        // Verify that the table view has three rows in the first section
        presenter.searchMovies(url: "search/movie?api_key=", key: "&language=es&query=Matrix")
        XCTAssertEqual(view.tableView(view.searchTableView, numberOfRowsInSection: view.movies.count), 6)
        view.showSearchMovies(movies: getMockPopularMovies())
        presenter.presenterSearchMovies(movies: view.movies)
        let view = HomeRouter.createModule()
        view.navigationController?.pushViewController(view, animated: true)
    }
    // Test the display information is valid
    func testCellForRow() {
        // Verify that the cell at row 0 has the correct text label
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = view.tableView(view.searchTableView, cellForRowAt: indexPath) as? MoviesTableViewCell
        XCTAssertNotNil(cell?.movieTitleLabel.text)
        XCTAssertNotNil(cell?.movieImage)
    }
    // Test when we don´t have onfromation to show
    func testNumberOfRowsInSectionWithoutMovies() {
        // Verify that the table view has three rows in the first section
        view.movies = []
        XCTAssertEqual(view.tableView(view.searchTableView, numberOfRowsInSection: 1), 1)
    }
    
    // Test valid fecth movies from API
    func testMovies_isNotNil_fetchMovies() {
        // Given
        let expectedMovies = 20
        // When
        guard let urlFetch = URL(string: "https://api.themoviedb.org/3/search/movie?api_key=f6cd5c1a9e6c6b965fdcab0fa6ddd38a&language=es&query=Matrix") else {
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
    
    // Mock of popular movies
    func getMockPopularMovies() -> [MovieProtocol] {
        let mockMockMovies: [MovieProtocol] = [Movie(id: 100, title: "Avengers", poster_path: "path/avengers"),
                                              Movie(id: 1726, title: "Iron Man", poster_path: "/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg"),
                                              Movie(id: 101, title: "Batman", poster_path: "path/batman"),
                                              Movie(id: 155, title: "El caballero oscuro", poster_path: "/8QDQExnfNFOtabLDKqfDQuHDsIg.jpg"),
                                              Movie(id: 102, title: "Spiderman", poster_path: "path/spidermanNoWayHome"),
                                              Movie(id: 604, title: "Matrix Reloaded", poster_path: "/ayZkaN2f3ASjWW8ooCfuJT3T8Va.jpg")]
        return mockMockMovies
    }
}

