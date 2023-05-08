//
//  MovieViewModelTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 07/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

/// A unit test class for MovieViewModel.
final class MovieViewModelTest: XCTestCase {
    
    // MARK: - Properties

    /// The subject under test.
    private var sut: MovieDetailViewController!
    let vm = MovieViewModel(Movie(id: 238, title: "The Godfather", poster_path: nil, overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.", release_date: nil, popularity: 102.666, vote_average: 8.7))
    
    // MARK: - Set up and tear down
    
    override func setUp() {
        super.setUp()
        
        // Set up the initial state of the subject under test.
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
        sut.movieVM = vm
    }
    
    override func tearDown() {
        // Clean up the state of the subject under test.
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Test methods
    
    /// Tests the scenario where the movie poster image is nil.
    func testMovieViewModel_ImageNil() {
        XCTAssertNil(sut.movieVM?.poster_path)
    }

    /// Tests the scenario where the release date of the movie is empty.
    func testMovieViewModel_YearEmpty() {
        let resultExpected = ""
        XCTAssertEqual(sut.movieVM?.year, resultExpected)
    }
    
    /// Tests the scenario where the favorite icon of the movie is checked.
    func testMovieViewModel_CheckFavoriteIcon() {
        
        sut.loadViewIfNeeded()

        guard let vm = sut.movieVM else { return }
        
        if vm.isFavorite() {
            sut.movieVM?.doFavoriteButtonAction()
            XCTAssertEqual(vm.icon_favorite, UIImage(systemName: "heart"))
        } else {
            sut.movieVM?.doFavoriteButtonAction()
            XCTAssertEqual(vm.icon_favorite, UIImage(systemName: "heart.fill"))
        }
    }
    
    /// Tests the scenario where the favorite icon of the movie is updated.
    func testMovieViewModel_UpdateFavoriteIcon() {
        sut.loadViewIfNeeded()
        
        let resultExpected = UIImage(systemName: "heart")
        
        sut.updateImageButton(image: resultExpected)
        XCTAssertEqual(sut.btnFavorite.image, resultExpected)
    }
    
    /// Tests the scenario where the favorite button action of the movie is checked.
    func testMovieViewModel_CheckFavoriteButtonAction() {
        
        sut.loadViewIfNeeded()

        guard let vm = sut.movieVM else { return }
        
        if vm.isFavorite() {
            sut.favoriteButtonAction(self)
            XCTAssertEqual(vm.icon_favorite, UIImage(systemName: "heart"))
        } else {
            sut.favoriteButtonAction(self)
            XCTAssertEqual(vm.icon_favorite, UIImage(systemName: "heart.fill"))
        }
    }
}
