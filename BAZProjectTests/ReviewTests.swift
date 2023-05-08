//
//  ReviewTests.swift
//  BAZProjectTests
//
//  Created by ksolano on 27/04/23.
//

import XCTest
@testable import BAZProject

final class ReviewTests: XCTestCase {
    
    var interactor: ReviewMoviesInteractor!
    var presenter: ReviewMoviesPresenter!
    var view: ReviewMoviesViewController!
    var router: ReviewMoviesRouter!
    var imageLoader: ImageLoader!
    var movieApi: MovieAPI!
    
    override func setUp() {
        super.setUp()
        movieApi = MovieAPI()
        imageLoader = ImageLoader()
        interactor = ReviewMoviesInteractor(movieAPI: movieApi)
        let storyboard = UIStoryboard(name: "ReviewMovies", bundle: nil)
        view = (storyboard.instantiateViewController(withIdentifier: "ReviewStory") as? ReviewMoviesViewController)
        view.loadViewIfNeeded()
        router = ReviewMoviesRouter()
        presenter = ReviewMoviesPresenter(view: view, interactor: interactor, router: router)
        interactor?.presenter = presenter
        view.movie = MockMoviesFecth.moviesFecth.first
        view.moviesSimiliar = MockMoviesFecth.moviesFecth
        view.moviesRecomendations = MockMoviesFecth.moviesFecth
    }
    
    override func tearDown() {
        super.tearDown()
        interactor = nil
        presenter = nil
        view = nil
        router = nil
    }
        
    func testInitTableOfSearch() {
        XCTAssertNotNil(view.registerTable())
    }
    
    func testMoviesFetchReviewCallPresenter() {
        XCTAssertNotNil(presenter.reviewMovies(url: "movie/603/reviews?api_key="))
    }
    
    func testNumberOfSectionsInCollection() {
        // Verify that the table view has one section
        XCTAssertEqual(view.recomendationsCollectionView.numberOfSections , 2)
    }
    
    func testNumberOfSectionsInTable() {
        // Verify that the table view has one section
        XCTAssertEqual(view.recomendationsCollectionView.numberOfSections , 2)
    }
    
    func testNumberOfRowsInSection() {
        // Verify that the table view has three rows in the first section
        XCTAssertEqual(view.collectionView(view.recomendationsCollectionView, numberOfItemsInSection: view.moviesSimiliar.count), 0)
        presenter?.recomendedMovies(url: "movie/603/recommendations?api_key=")
        presenter?.similarMovies(url: "movie/603/similar?api_key=")
        XCTAssertNotNil(view.showSimilarMovies(similarMovies: view.moviesSimiliar))
        XCTAssertNotNil(view.showRecomendedMovies(recomendedMoviess: view.moviesRecomendations))
    }
    
    func testPopViewController() {
        XCTAssertNotNil(presenter.popViewController())
    }
    
    func testShowReviewMoviesInTVC() {
        XCTAssertNotNil(view.showReviewMovies(movie: MockMoviesFecth.moviesmockReview))
    }
    
    func testCellForRowTableReview() {
        XCTAssertNotNil(view.reviewTableView)
        // Verify that the cell at row 0 has the correct text label
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = view.tableView(view.reviewTableView, cellForRowAt: indexPath) as? MoviesTableViewCell
        XCTAssertNotNil(cell?.movieTitleLabel)
        XCTAssertNotNil(cell?.movieImage)
        let indexPath2 = IndexPath(row: 0, section: 1)
        let cell2 = view.tableView(view.reviewTableView, cellForRowAt: indexPath2) as? InfoReviewTableViewCell
        XCTAssertNotNil(cell2?.infoLabel)
        XCTAssertNotNil(cell2?.ratingLabel)
    }
    
    func testCellForRowCollectionRecomended() {
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = view.collectionView(view.recomendationsCollectionView, cellForItemAt: indexPath) as? MoviesCollectionViewCell
        XCTAssertNotNil(cell?.movieTitle.text)
        let indexPath1 = IndexPath(row: 0, section: 1)
        let cell1 = view.collectionView(view.recomendationsCollectionView, cellForItemAt: indexPath1) as? MoviesCollectionViewCell
        XCTAssertNotNil(cell1?.movieTitle.text)
    }
    
    func testSelectAnyRecomended() {
        var indexPath = IndexPath(row: 0, section: 0)
        XCTAssertNotNil(view.collectionView(view.recomendationsCollectionView, didSelectItemAt: indexPath))
        indexPath.section = 1
        XCTAssertNotNil(view.collectionView(view.recomendationsCollectionView, didSelectItemAt: indexPath))
    }
    
}

