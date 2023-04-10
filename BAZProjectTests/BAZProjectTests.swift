//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by ksolano on 30/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {

    var sut: TrendingViewController!
    var imageLoader: ImageLoader = ImageLoader()
    var movieAPI: MovieAPI = MovieAPI()
    
    override func setUp() {
        super.setUp()
        sut = TrendingViewController()
        sut.movies = getPopularMovies()
    }
    
    override func tearDown() {
        super.tearDown()
        sut = nil
    }
    
    func testMovies_isNotNil_countMovies() {
        // Given
        let expectedMovies = 6
        // When
        sut.movies = getPopularMovies()
        // Then
        XCTAssertNotNil(sut.movies)
        XCTAssertEqual(sut.movies.count, expectedMovies)
    }
    
    func testIsAvailableMovies_getMovies_movieToShow() {
        // this function depends of testMovies_isNotNil_countMovies result
        // Given
        let isAvailableExpected = true
        // When
        sut.movies = getPopularMovies()
        //Then
        XCTAssertTrue(sut.movies.count > 0 )
        XCTAssertEqual(sut.verifyInformation(movies: sut.movies), isAvailableExpected)
    }
    
    func testMoviesImages_getMoviesInfoPicture_isAvailable() {
        // this function depends of testIsAvailableMovies_getMovies_movieToShow result
        // Given
        let pathExpected = URL(string: "https://image.tmdb.org/t/p/w500/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg")
        // When
        sut.movies = getPopularMovies()
        let urlMovie = sut.getURLImage(poster_path: sut.movies[1].poster_path)
        // Then
        XCTAssertEqual(urlMovie, pathExpected)
        imageLoader.loadImage(urlData: urlMovie!) { image in
            XCTAssertNil(image)
        }
    }
    
    func testId_getMoviesId_IdValid() {
        // Given
        let expectedId = 100
        let expectedValidation = true
        // When
        sut.movies = getPopularMovies()
        // Then
        // With protocol with protocols we avoid data type errors
        XCTAssertTrue(sut.movies.count > 0 )
        XCTAssertEqual(sut.verificationId(movieIndex: 0), expectedValidation)
        XCTAssertEqual(sut.movies[0].id, expectedId)
    }
    
    func testTableView_numberOfRows_isGreaterThanZeroAndEqualToMovies() {
        sut.loadViewIfNeeded()
        
        XCTAssertTrue(sut.tableView.dataSource!.tableView(sut.tableView, numberOfRowsInSection: sut.movies.count ) > 0)
        XCTAssertEqual(sut.tableView.dataSource!.tableView(sut.tableView, numberOfRowsInSection: sut.movies.count), sut.movies.count)
    }
    
    func testTitle_getTitleOfMovies_isValidTitle() {
        let titleExpected = "Matrix Reloaded"
        
        XCTAssertNotNil(sut.movies)
        XCTAssertEqual(sut.tableView.dataSource!.tableView(sut.tableView, numberOfRowsInSection: sut.movies.count), sut.movies.count)
        XCTAssertEqual(sut.movies.last?.title, titleExpected)
    }
    
    // Mock of popular movies
    func getPopularMovies() -> [MovieProtocol] {
        let popularMovies: [MovieProtocol] = [Movie(id: 100, title: "Avengers", poster_path: "path/avengers"),
                                              Movie(id: 1726, title: "Iron Man", poster_path: "/tFCTNx7foAsUQpgu2x1KjAJD1wT.jpg"),
                                              Movie(id: 101, title: "Batman", poster_path: "path/batman"),
                                              Movie(id: 155, title: "El caballero oscuro", poster_path: "/8QDQExnfNFOtabLDKqfDQuHDsIg.jpg"),
                                              Movie(id: 102, title: "Spiderman", poster_path: "path/spidermanNoWayHome"),
                                              Movie(id: 604, title: "Matrix Reloaded", poster_path: "/ayZkaN2f3ASjWW8ooCfuJT3T8Va.jpg")]
        return popularMovies
    }
    
    func testGetMovies_moviesAPIInformation() {
        let expectedMovies = 8
        var moviesGet = 0
        movieAPI.getMovies { movies in
           XCTAssertNotNil(movies)
        }
    }

    // This is a Mock struct for model popular movies that extends of protocol MovieProtocol
    private struct PopularMockMoviesData: MovieProtocol  {
        var id: Int
        var title: String
        var poster_path: String
        var image: UIImage
        var adult: Bool?
        var backdrop_path: String?
        var genre_ids: [Int]?
        var media_type: String?
        var original_language: String?
        var original_title: String?
        var overview: String?
        var popularity: String?
        var release_date: String?
        var video: Bool?
        var vote_average: String?
        var vote_count: String?
    }
}
