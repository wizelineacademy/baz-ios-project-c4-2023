//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by Carlos Garcia on 07/04/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {
    
    var homeInteractor: HomeInteractor?
    var homeMock: MockPresenter?
    
    var detailsInteractor: MovieDetailsInteractor?
    var detailsMock: MockDetailsPresenter?
    
    var api: MovieAPI?
    
    override func setUp() {
        super.setUp()
        homeInteractor = HomeInteractor()
        homeMock = MockPresenter()
        api = MovieAPI()
        homeInteractor?.presenter = homeMock
        
        detailsMock = MockDetailsPresenter()
        detailsInteractor = MovieDetailsInteractor(presenter: detailsMock, entity: nil, movieAPI: api, movie: nil, storageManager: StorageManager(storage: FileManager.default))
    }
    
    override func tearDown() {
        super.tearDown()
        homeInteractor = nil
        homeMock = nil
        api = nil
        detailsInteractor = nil
        detailsMock = nil
    }

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testInteractor_getSectionDataGreaterThanZero_updateSectionData() throws {
        homeInteractor?.setSectionsData()
        if let arrSections = homeMock?.arrSections {
            XCTAssertGreaterThan(arrSections.count, 0)
        } else {
            fatalError("Mock nil")
        }
    }
    
    func testAPI_getTrendingMoviesGreaterThanZero_showMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        api?.getTrendingMovies { movies in
            XCTAssertGreaterThan(movies?.count ?? 0, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAPI_getNowPlayingMoviesGreaterThanZero_showMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        api?.getNowPlayingMovies { movies in
            XCTAssertGreaterThan(movies?.count ?? 0, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAPI_getPopularMoviesGreaterThanZero_showMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        api?.getPopularMovies { movies in
            XCTAssertGreaterThan(movies?.count ?? 0, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testAPI_getMoviesFoundNotNil_showMovies() throws {
        api?.searchMoviesfor(keyword: "matrix") { movies in
            XCTAssertNotNil(movies)
        }
    }
    
    func testAPI_getMoviesFoundGreaterThanZero_showMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        api?.searchMoviesfor(keyword: "matrix") { movies in
            XCTAssertGreaterThan(movies?.count ?? 0, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testResourse_getImageCoverNotNil_showCoverImage() throws {
        let path: String = "/vZloFAK7NmvMGKE7VkF5UHaz0I.jpg"
        ResourcesManager().downloadImage(from: path) { image in
            XCTAssertNotNil(image)
        }
    }
    
    func testMovieDetails_getMovieNotNil_showMovieInfo() throws {
        let movieID = 361743
        api?.searchMovieDetails(for: movieID) { movie in
            XCTAssertNotNil(movie)
        }
    }
    
    func testMovieReviews_getMovieReviewsGreaterThanZero_fetchMovieReviews() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        
        let movieID = 361743
        detailsInteractor?.entity = MovieDetailsEntity(movie: Movie(id: movieID, title: "", posterPath: nil))
        detailsInteractor?.fetchMovieReviews()

        self.detailsMock?.complationReviews = { reviews in
            XCTAssertGreaterThan(reviews.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testSimilarMovies_getSimilarMoviesGreaterThanZero_fetchSimilarMovies() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        
        let movieID = 361743
        detailsInteractor?.entity = MovieDetailsEntity(movie: Movie(id: movieID, title: "", posterPath: nil))
        detailsInteractor?.fetchSimilarMovies()

        self.detailsMock?.complationSimilarMovies = { movies in
            XCTAssertGreaterThan(movies.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testRecommendedMovies_getRecommendedMoviesGreaterThanZero_fetchRecommendations() throws {
        let expectation = XCTestExpectation(description: "Get data successfully")
        
        let movieID = 361743
        detailsInteractor?.entity = MovieDetailsEntity(movie: Movie(id: movieID, title: "", posterPath: nil))
        detailsInteractor?.fetchRecommendations()

        self.detailsMock?.complationRecommendedMovies = { movies in
            XCTAssertGreaterThan(movies.count, 0)
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 5.0)
    }
    
    func testFileManager_saveMovieIsTrue_saveToFavorites() throws {
        let movie = Movie(id: 624860, title: "The Matrix Resurrections", posterPath: "/dLIwpCTf4QoW01pp85KP9jcfTpu.jpg")
        detailsInteractor?.entity = MovieDetailsEntity(movie: movie)
        detailsInteractor?.saveToFavorites()
        let isFavorite = detailsMock?.isFavorite ?? false
        XCTAssertTrue(isFavorite)
    }
    
    func testFileManager_getMovieNotNil_getFavoriteMovies() throws {
        let movie = Movie(id: 624860, title: "The Matrix Resurrections", posterPath: "/dLIwpCTf4QoW01pp85KP9jcfTpu.jpg")
        detailsInteractor?.entity = MovieDetailsEntity(movie: movie)
        detailsInteractor?.saveToFavorites()
        let favoriteMovies = detailsInteractor?.getFavoriteMovies()
        XCTAssertNotNil(favoriteMovies?.movies)
    }
    
    func testFileManager_deleteMovieIsTrue_saveToFavorites() throws {
        let movie = Movie(id: 624860, title: "The Matrix Resurrections", posterPath: "/dLIwpCTf4QoW01pp85KP9jcfTpu.jpg")
        detailsInteractor?.entity = MovieDetailsEntity(movie: movie)
        detailsInteractor?.removeFromFavorites()
        let isFavorite = detailsMock?.isFavorite ?? true
        XCTAssertFalse(isFavorite)
    }
}

class MockPresenter: HomeInteractorOutputProtocol {
    var arrSections: [MovieSection] = []
    var arrMoviesFound: [MovieFoundInfo]?
    
    func updateSectionsData(_ sectionData: [MovieSection]) {
        arrSections = sectionData
    }
    
    func updateMovies(_ movies: [MovieInfo]?, in section: Int) {
        guard let movies = movies else {
            return
        }
        arrSections[section].movies = movies
    }
    
    func updateMoviesFound(_ movies: [MovieFoundInfo]?) {
        arrMoviesFound = movies
    }
}

class MockDetailsPresenter: MovieDetailsInteractorOutputProtocol {
    var movieDetails: MovieDetailsInfo?
    var reviews: [MovieReviewInfo] = []
    var similarMovies: [MovieInfo] = []
    var recommendedMovies: [MovieInfo] = []
    var credits: MovieCreditsInfo?
    var isFavorite: Bool = false
    
    var complationReviews: ( ([MovieReviewInfo]) -> Void )?
    var complationSimilarMovies: ( ([MovieInfo]) -> Void )?
    var complationRecommendedMovies: ( ([MovieInfo]) -> Void )?
    
    func presentMovieDetails(_ movie: MovieDetailsInfo?) {
        self.movieDetails = movie
    }
    
    func presentMovieCredits(_ credits: MovieCreditsInfo?) {
        self.credits = credits
    }
    
    func presentMovieBackdropImage(_ image: UIImage?) {}
    
    func presentMovieReviews(_ reviews: [MovieReviewInfo]?) {
        guard let reviews = reviews else {
            return
        }
        self.reviews = reviews
        self.complationReviews?(self.reviews)
    }
    
    func presentSimilarMovies(_ movies: [MovieInfo]?) {
        guard let movies = movies else {
            return
        }
        self.similarMovies = movies
        self.complationSimilarMovies?(self.similarMovies)
    }
    
    func presentRecommendations(_ movies: [MovieInfo]?) {
        guard let movies = movies else {
            return
        }
        self.recommendedMovies = movies
        self.complationRecommendedMovies?(self.recommendedMovies)
    }
    
    func presentFavoriteMovie(_ isFavorite: Bool) {
        self.isFavorite = isFavorite
    }
}
