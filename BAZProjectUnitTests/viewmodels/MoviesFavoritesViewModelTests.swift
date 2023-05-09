//
//  MoviesFavoritesViewModelTests.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 08/05/23.
//

import XCTest
import CoreData
@testable import BAZProject

final class MoviesFavoritesViewModelTests: XCTestCase {

    var viewModel: MoviesFavoritesViewModel!
    var movie: Movie!
    let mockContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext

    override func setUp() {
        super.setUp()
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieFavorite")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        do {
            try mockContext.execute(deleteRequest)
            try mockContext.save()
        } catch {
            print("Error al borrar los datos: \(error)")
        }
        viewModel = MoviesFavoritesViewModel()
        movie = Movie(id: 1, title: "Test", posterPath: "posterPath", overview: "Overview", voteAverage: 8.0, releaseDate: "2019-09-13")
        viewModel.addMovieToFavorites(movie)
    }
    
    override func tearDown() {
        super.tearDown()
        viewModel.removeMovieFavorite(1)
        viewModel = nil
        movie = nil
    }
    
    func testFetchMoviesFavorites() {
        let expectation = self.expectation(description: "Películas obtenidas con éxito")
        viewModel.onMoviesUpdate = {
            expectation.fulfill()
        }
        viewModel.fetchMoviesFavorites()
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssertTrue(viewModel.movies.count > 0)
    }
    
    func testAddMovieToFavorites() {
        XCTAssertTrue(viewModel.isMovieFavorite == true)
    }
    
    func testSetupMovieFavorite() {
        viewModel.setupMovieFavorite(1)
        XCTAssertTrue(viewModel.isMovieFavorite == true)
        viewModel.setupMovieFavorite(1)
        XCTAssertFalse(viewModel.isMovieFavorite == false)
    }
    
    func testRemoveMovieFavorite() {
        viewModel.removeMovieFavorite(1)
        viewModel.fetchMoviesFavorites()
        XCTAssertTrue(viewModel.movies.count == 0)
    }
}
