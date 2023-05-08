//
//  FavouritesMoviesTests.swift
//  BAZProjectTests
//
//  Created by ksolano on 27/04/23.
//

import XCTest
@testable import BAZProject

final class FavouriteTests: XCTestCase {
    
    var interactor: FavouriteMoviesInteractor!
    var presenter: FavouriteMoviesPresenter!
    var view: FavouriteMoviesViewController!
    var router: FavouriteMoviesRouter!
    var imageLoader: ImageLoader!
    var movieApi: MovieAPI!
    var favoriteManager: FavouriteManager!
    
    override func setUp() {
        super.setUp()
        favoriteManager = FavouriteManager()
        movieApi = MovieAPI()
        imageLoader = ImageLoader()
        interactor = FavouriteMoviesInteractor(movieAPI: movieApi, favouriteManager: favoriteManager)
        let storyboard = UIStoryboard(name: "FavouritesMovies", bundle: nil)
        view = (storyboard.instantiateViewController(withIdentifier: "FavouriteStory") as? FavouriteMoviesViewController)
        view.loadViewIfNeeded()
        router = FavouriteMoviesRouter()
        presenter = FavouriteMoviesPresenter(view: view, interactor: interactor, router: router)
        interactor?.presenter = presenter
        view.movies = MockMoviesFecth.moviesFecth
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
        presenter = nil
        view = nil
        router = nil
    }
    // test register table for show all the favourites movies
    func testInitTableOfSearch() {
        XCTAssertNotNil(view.registerTable())
    }
    // test call to fetch all favourites movies
    func testMoviesFetchReviewCallPresenter() {
        XCTAssertNotNil(presenter.favouriteMovies())
    }
    // test number of sections of the table favourites
    func testNumberOfSectionsInTable() {
       XCTAssertEqual(view.favoritesTableView.numberOfSections , 1)
    }
    // test to delete all fovourites movies that have in UserDefaults
    func testWhenDeleteFavourites() {
        XCTAssertNotNil(presenter.deleteFavouritesMovies())
    }
    
    // Test number of items in a section and informatión not nil
    func testCellForRow() {
        XCTAssertNotNil(view.favoritesTableView)
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = view.tableView(view.favoritesTableView, cellForRowAt: indexPath) as? MoviesTableViewCell
        XCTAssertNotNil(cell?.movieTitleLabel)
        XCTAssertNotNil(cell?.movieImage)
    }
    // test pop to Home
    func testPopViewController() {
        XCTAssertNotNil(presenter.popViewController())
    }
}

