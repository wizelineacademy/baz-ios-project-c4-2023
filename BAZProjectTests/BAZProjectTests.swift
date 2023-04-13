//
//  BAZProjectTests.swift
//  BAZProjectTests
//
//  Created by nmorenoa on 28/03/23.
//

import XCTest
@testable import BAZProject

final class BAZProjectTests: XCTestCase {

    private var sut: ServiceMocks!
    private var sessionMock = URLSessionMock()
    private var arrResults: [Movie]?
    private var sut2: TrendingViewController!
    
    override func setUp() {
        super.setUp()
        sut = ServiceMocks(sessionMock: sessionMock)
        sut2 = TrendingViewController()
        sut2.movies = getMovies()
    }

    override func tearDown() {
        sut = nil
        arrResults = nil
        sut2 = nil
        super.tearDown()
    }
    
    func testGetApiMovie_Has_Information(){
        //Given
        let expectation = XCTestExpectation(description: "Wait for requestMovieAPIBlock completion")
        sut2.movies = getMovies()
        //When
        sut.getMovies(.getMovieDay){ (result: Result< [Movie], Error>) in
            switch result {
            case .success(let success):
                self.arrResults = success
            case .failure(_):
                self.arrResults = nil
            }
        }
        expectation.fulfill()
        wait(for: [expectation], timeout: 0.1)
        XCTAssertNil(arrResults)
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
    
    func test_When_getTitleMoviesLast_ValidTitle() {
        let titleExpected = "AntMan"
        XCTAssertEqual(sut2.movies.last?.title, titleExpected)
    }
    
    func test_When_getTitleMoviesFirst_ValidTitle() {
        let titleExpected = "Spiderman"
        XCTAssertEqual(sut2.movies.first?.title, titleExpected)
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
    
    func getUrlImage(posterPath: String) -> URL? {
        let base = "https://image.tmdb.org/t/p/w500"
        return URL(string: base + posterPath)
    }

}
