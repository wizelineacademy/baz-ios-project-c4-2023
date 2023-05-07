//
//  MovieViewModelTest.swift
//  BAZProjectTests
//
//  Created by jmgarciaca on 07/05/23.
//

import XCTest
import UIKit
@testable import BAZProject

final class MovieViewModelTest: XCTestCase {

    private var sut: MovieDetailViewController!
    let vm = MovieViewModel(Movie(id: 238, title: "The Godfather", poster_path: nil, overview: "Spanning the years 1945 to 1955, a chronicle of the fictional Italian-American Corleone crime family. When organized crime family patriarch, Vito Corleone barely survives an attempt on his life, his youngest son, Michael steps in to take care of the would-be killers, launching a campaign of bloody revenge.", release_date: nil, popularity: 102.666, vote_average: 8.7))
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: "MovieDetailVC") as! MovieDetailViewController
        sut.movieVM = vm
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testMovieViewModel_ImageNil() {
        XCTAssertNil(sut.movieVM?.poster_path)
    }

    func testMovieViewModel_YearEmpty() {
        let resultExpected = ""
        XCTAssertEqual(sut.movieVM?.year, resultExpected)
    }
    
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
    
    func testMovieViewModel_UpdateFavoriteIcon() {
        sut.loadViewIfNeeded()
        
        let resultExpected = UIImage(systemName: "heart")
        
        sut.updateImageButton(image: resultExpected)
        XCTAssertEqual(sut.btnFavorite.image, resultExpected)
    }
    
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
