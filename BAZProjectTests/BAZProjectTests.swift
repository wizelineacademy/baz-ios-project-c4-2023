//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 28/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {

    private var serviceMock: ServiceMocks!
    private var sessionMock = URLSessionMock()
    private var arrResults: [Movie]?
    private var sut2: TrendingViewController!
    private var interactorMock: SearchMoviesInteractorTest!
    private var movieModels: MoviesViewModels?
    
    override func setUp() {
        super.setUp()
        serviceMock = ServiceMocks(sessionMock: sessionMock)
        sut2 = TrendingViewController()
        sut2.movies = getMovies()
    }

    override func tearDown() {
        serviceMock = nil
        arrResults = nil
        sut2 = nil
        interactorMock = nil
        super.tearDown()
    }
    
    func test_When_GetMovies(){
        // Given
        let expectedGetMovies = 7
        // When
        sut2.movies = getMovies()
        // Then
        XCTAssertNotNil(sut2.movies)
        XCTAssertEqual(sut2.movies.count, expectedGetMovies)
    }
    
    func testNotNilMock(){
        XCTAssertNotNil(serviceMock)
    }
    
    func test_When_getTitleMoviesLast_ValidTitle() {
        let titleExpected = "AntMan"
        XCTAssertEqual(sut2.movies.last?.title, titleExpected)
    }
    
    func test_When_getTitleMoviesFirst_ValidTitle() {
        let titleExpected = "Spiderman"
        XCTAssertEqual(sut2.movies.first?.title, titleExpected)
    }
    
    func test_WhenTitleIsNil(){
        XCTAssertNil(sut2.btnOptionsFilterMovies)
    }
    
    func testMoviesImages_getMoviesInfoPicture_isAvailable() {
        // Given
        let pathExpected = URL(string: "https://image.tmdb.org/t/p/w500/path/Spiderman.jpg")
        // When
        sut2.movies = getMovies()
        guard let urlMovie = getUrlImage(posterPath: sut2.movies.first?.poster_path ?? "") else { return }
        // Then
        XCTAssertEqual(urlMovie, pathExpected)
    }
    
    func getMovies() -> [MovieData] {
        let popularMovies: [MoviesViewModels] = [MoviesViewModels(title: "Spiderman", poster_path: "/path/Spiderman.jpg"),
                                                 MoviesViewModels(title: "Batman", poster_path: "/path/Batman.jpg"),
                                                 MoviesViewModels(title: "Superman", poster_path: "/path/Superman.jpg"),
                                                 MoviesViewModels(title: "Thor", poster_path: "/path/Thor.jpg"),
                                                 MoviesViewModels(title: "Avatar", poster_path: "/path/Avatar.jpg"),
                                                 MoviesViewModels(title: "Thor", poster_path: "/path/Thor.jpg"),
                                                 MoviesViewModels(title: "AntMan", poster_path: "/path/AntMan.jpg")]
        return popularMovies
    }
    
    func test_ValidateImage(){
        getMovies().first?.getImage{ imagen in
            XCTAssertNotNil(imagen)
        }
    }
    
    func getUrlImage(posterPath: String) -> URL? {
        let base = "https://image.tmdb.org/t/p/w500"
        return URL(string: base + posterPath)
    }

}
