//
//  DetailsViewModelTests.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//
import XCTest
@testable import BAZProject

final class DetailsViewModelTests: XCTestCase {
    
    var sut: DetailsViewModel?
    var movieAPIMock: MovieApiMock?

    override func setUp() {
        super.setUp()
        movieAPIMock = MovieApiMock(service: ServiceAPI(session: SessionMock()))
        sut = DetailsViewModel(movieDetail: Movie(), remote: movieAPIMock!)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    //MARK: - Pruebas de pantalla principal
    
    func testDetailsModel_MovieExist() {
        //Given
        let movie = Movie(id: 1, title: "John Wick", poster_path: "")
        //When
        sut?.movieDetail = Box(value: movie)
        let name = sut?.getTitle()
        //Then
        XCTAssertEqual(name, movie.title)
    }

    func testDetailsModel_HasVotes() {
        //Given
        let votes = "10.0"
        let movie = Movie(id: 1, title: "John Wick", poster_path: "", overview: "", vote_average: 10.0)
        //When
        sut?.movieDetail = Box(value: movie)
        let ranking = sut?.getRating()
        //Then
        XCTAssertEqual(votes, ranking)
    }
    
    func testDetailsModel_HasOverview() {
        //Given
        let movie = Movie(id: 1, title: "John Wick", poster_path: "", overview: "El matador", vote_average: 10.0)
        //When
        sut?.movieDetail = Box(value: movie)
        let overV = sut?.getOverview()
        //Then
        XCTAssertNotNil(overV)
    }
     
    func testDetailsModel_HasPath() {
        //Given
        let image = "JW.png"
        let movie = Movie(id: 1, title: "John Wick", poster_path: "JW.png", overview: "", vote_average: 10.0)
        //When
        sut?.movieDetail = Box(value: movie)
        let overV = sut?.getPathImage()
        //Then
        XCTAssertEqual(overV, image)
    }
    
    func testDetailsModel_HasRating() {
        //Given
        let expectedResult = "10.0"
        let movie = Movie(id: 1, title: "John Wick", poster_path: "JW.png", overview: "", vote_average: 10.0)
        //When
        sut?.movieDetail = Box(value: movie)
        let rating = sut?.getRating()
        //Then
        XCTAssertEqual(expectedResult, rating)
    }
    
    func testDetailsModel_IsFavorite() {
        //Given
        let isFav = false
        let movie = Movie(id: 1, title: "John Wick", poster_path: "JW.png", overview: "", vote_average: 10.0)
        //When
        sut?.movieDetail = Box(value: movie)
        let favBool = sut?.isMovieFavorite()
        //Then
        XCTAssertEqual(isFav, favBool)
    }
    
    func testDetailsModel_SavedUSerDefaults() {
        //Given
        let movie = Movie(id: 1, title: "John Wick", poster_path: "JW.png", overview: "", vote_average: 10.0)
        //When
        sut?.movieDetail = Box(value: movie)
        sut?.saveUserDefautls(key: UserDKeys.favoriteTests.rawValue)
        let savedData = getUDMovies(key: UserDKeys.favoriteTests.rawValue)
        //Then
        XCTAssertNotNil(savedData)
    }
    
    func testDetailsModel_DeleteUSerDefaults() {
        //Given
        sut?.userDefaults.removeObject(forKey: UserDKeys.favoriteTests.rawValue)
        let movie = Movie(id: 2, title: "John Wick", poster_path: "JW.png", overview: "", vote_average: 10.0)
        let expectedResult = 0
        //When
        sut?.movieDetail = Box(value: movie)
        sut?.saveUserDefautls(key: UserDKeys.favoriteTests.rawValue)
        sut?.deteleUserDefautls(key: UserDKeys.favoriteTests.rawValue)
        let savedData = getUDMovies(key: UserDKeys.favoriteTests.rawValue)
        //Then
        XCTAssertEqual(expectedResult, savedData.value.count)
    }
    
    //MARK: - Funciones auxiliares
    func getUDMovies(key: String) -> Box<[Movie]> {
        var movieArray = Box(value: [Movie()])
        do {
            if let data = UserDefaults.standard.data(forKey: key) {
                let UDData = try JSONDecoder().decode([Movie].self, from: data)
                movieArray = Box(value: UDData)
            }
        } catch {
            print("Can not store:", error)
        }
        return movieArray
    }
    
    
    //MARK: - Pruebas de Seccion de recomendaciones
    
    
    func testDetailsViewModel_getRecommendationMovies() {
        //Given
        let movies = [Movie(id: 1, title: "Payasos asesinos del espacio exterior", poster_path: "", overview: "", vote_average: 10.0)]
        let expectation = XCTestExpectation()
        //When
        movieAPIMock?.movies = movies
        sut?.bindMovie { expectation.fulfill() }
        sut?.getRecommendationMovies()
        wait(for: [expectation], timeout: 0.5)
        let count = sut?.getRecommendationMoviesCount()
        //Then
        XCTAssertEqual(count, movies.count)
    }
    
    func testDetailsModel_RecommendatioMovieExist() {
        //Given
        let movie = [Movie(id: 1, title: "Payasos asesinos del espacio exterior", poster_path: "", overview: "", vote_average: 10.0)]
        //When
        sut?.recommendationMovies = Box(value: movie)
        let name = sut?.getRecommendationMoviesTitle(index: 0)
        //Then
        XCTAssertEqual(name, movie[0].title)
    }
    
    func testDetailsModel_RecommendatioMoviePathExist() {
        //Given
        let movie = [Movie(id: 1, title: "Payasos asesinos del espacio exterior", poster_path: "", overview: "", vote_average: 10.0)]
        //When
        sut?.recommendationMovies = Box(value: movie)
        let path = sut?.getRecommendationPath(index: 0)
        //Then
        XCTAssertEqual(path, movie[0].poster_path)
    }

    
    //MARK: - Pruebas de Seccion de Similares
    
    func testDetailsViewModel_getSimilarMovies() {
        //Given
        let movies = [Movie(id: 1, title: "Payasos asesinos del espacio exterior", poster_path: "", overview: "", vote_average: 10.0)]
        let expectation = XCTestExpectation()
        //When
        movieAPIMock?.movies = movies
        sut?.bindMovie { expectation.fulfill() }
        sut?.getSimilarMovies()
        wait(for: [expectation], timeout: 0.5)
        let count = sut?.getSimilarMoviesCount()
        //Then
        XCTAssertEqual(count, movies.count)
    }
    
    func testDetailsModel_SimilarMovieExist() {
        //Given
        let movie = [Movie(id: 1, title: "Payasos asesinos del espacio exterior", poster_path: "")]
        //When
        sut?.similarMovies = Box(value: movie)
        let name = sut?.getSimilarMoviesTitle(index: 0)
        //Then
        XCTAssertEqual(name, movie[0].title)
    }

    func testDetailsModel_SimilarMoviePathExist() {
        //Given
        let movie = [Movie(id: 1, title: "Payasos asesinos del espacio exterior", poster_path: "", overview: "", vote_average: 10.0)]
        //When
        sut?.similarMovies = Box(value: movie)
        let path = sut?.getSimilarPath(index: 0)
        //Then
        XCTAssertEqual(path, movie[0].poster_path)
    }
    
    //MARK: - Pruebas de Seccion de Reparto
    
    
    func testDetailsViewModel_getCastMovie() {
        //Given
        let cast = [Cast(id: 1, name: "Henry Cavil", profile_path: "", character: "Superman")]
        let expectation = XCTestExpectation()
        //When
        movieAPIMock?.cast = cast
        sut?.bindMovie { expectation.fulfill() }
        sut?.getCastMovie()
        wait(for: [expectation], timeout: 0.5)
        let count = sut?.getCastMovieMoviesCount()
        //Then
        XCTAssertEqual(count, cast.count)
    }
    
    func testDetailsModel_CastMovieExist() {
        //Given
        let cast = [Cast(id: 1, name: "Henry Cavil", profile_path: "", character: "Superman")]
        //When
        sut?.castMovie = Box(value: cast)
        let name = sut?.getCastMovieTitle(index: 0)
        //Then
        XCTAssertEqual(name, cast[0].name)
    }

    func testDetailsModel_CastMoviePathExist() {
        //Given
        let cast = [Cast(id: 1, name: "Henry Cavil", profile_path: "Henry.jpg", character: "Superman")]
        //When
        sut?.castMovie = Box(value: cast)
        let path = sut?.getCastPath(index: 0)
        //Then
        XCTAssertEqual(path, cast[0].profile_path)
    }
    
    func testDetailsModel_CastMovieCharacter() {
        //Given
        let cast = [Cast(id: 1, name: "Henry Cavil", profile_path: "Henry.jpg", character: "Superman")]
        //When
        sut?.castMovie = Box(value: cast)
        let character = sut?.getCastMovieMoviesCharacter(index: 0)
        //Then
        XCTAssertEqual(character, cast[0].character)
    }
    
}
