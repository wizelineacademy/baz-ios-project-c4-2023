//
//  FavoriteViewModelTests.swift
//  BAZProject
//
//  Created by Manuel S on 01/05/23.
//

import XCTest
@testable import BAZProject

final class FavoriteViewModelTests: XCTestCase {
    
    var sut: FavoritesViewModel?

    override func setUp() {
        super.setUp()
        
        sut = FavoritesViewModel()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testFavoriteModel_countNotNil() {
        //Given
        let movies = [Movie(id: 1, title: "Mario Bros", poster_path: "")]
        //When
        sut?.favoriteMovies = Box(value: movies)
        let count = sut?.getMovieCount()
        //Then
        XCTAssertEqual(count, movies.count)
    }
    
    func testFavoriteModel_TitleNotNil() {
        //Given
        let movies = [Movie(id: 1, title: "Mario Bros", poster_path: "")]
        //When
        sut?.favoriteMovies = Box(value: movies)
        let title = sut?.getTitle(index: 0)
        //Then
        XCTAssertEqual("Mario Bros", title)
    }
    
    func testFavoriteModel_PathNotNil() {
        //Given
        let ExpectedPath = "MarioBros.png"
        let movies = [Movie(id: 1, title: "MarioBros", poster_path: "MarioBros.png")]
        //When
        sut?.favoriteMovies = Box(value: movies)
        let path = sut?.getPathImage(index: 0)
        //Then
        XCTAssertEqual(ExpectedPath, path)
    }
    
    func testFavoriteModel_MovieInfoExist() {
        let movies = [Movie(id: 1, title: "Avatar", poster_path: "avatar.png")]
        //When
        sut?.favoriteMovies = Box(value: movies)
        let movie = sut?.getAllInfoMoview(index: 0)
        //Then
        XCTAssertEqual(movie?.title, movies[0].title)
    }
    
    func testFavoriteModel_FavoriteList_NotNil() {
        //When
        saveUserDefautls()
        //Then
        sut!.getFavoritesMovies(key: DefaultsKey.favoriteTests.rawValue)
        XCTAssertNotNil(sut?.favoriteMovies)
    }
    
    func saveUserDefautls() {
        let movies = Movie(id: 1, title: "Avatar", poster_path: "avatar.png")
        do {
            if let data = UserDefaults.standard.data(forKey: DefaultsKey.favoriteTests.rawValue) {
                var UDData = try JSONDecoder().decode([Movie].self, from: data)
                UDData.append(movies)
                let data = try JSONEncoder().encode(UDData)
                UserDefaults.standard.set(data, forKey: DefaultsKey.favoriteTests.rawValue)
            } else {
                let data = try JSONEncoder().encode([movies])
                UserDefaults.standard.set(data, forKey: DefaultsKey.favoriteTests.rawValue)
            }
            
        } catch {
            print("Can not store:", error)
        }
    }
}
