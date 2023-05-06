//
//  DetailsViewTests.swift
//  BAZProject
//
//  Created by Manuel S on 04/05/23.
//

import XCTest
@testable import BAZProject

final class DetailsViewTests: XCTestCase {
    
    var sut: DetailsViewController!
    var viewModel = DetailsViewModel(movieDetail: Movie(id: 1, title: "Evil Dead", poster_path: "evil.jpg", overview: "Esta si asista", vote_average: 8.0))
    
    override func setUp() {
        super.setUp()
        sut = DetailsViewController(viewModel: viewModel)
        sut.viewModel = viewModel
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    // MARK: - Pruebas de pantalla principal
    
    func testDetailsView_TitleIsEqualToViewModel() {
        //Given
        sut.loadViewIfNeeded()
        //When
        XCTAssertEqual(sut.navigationItem.title, viewModel.getTitle())
    }
    
    func testDetailsView_ImageIsNotFavorite() {
        //Given
        sut.loadViewIfNeeded()
        let image = sut.favoriteButton.imageView
        //When
        XCTAssertFalse(image == Icon.heartFill)
    }
    
    func testDetailsView_MIsNotFavorite() {
        //Given
        sut.loadViewIfNeeded()
        sut.favoriteButton(sut.favoriteButton)
        let image = sut.favoriteButton.imageView
        
        //When
        XCTAssertFalse(image == Icon.heartFill)
    }
    
    // MARK: - Pruebas de similares
    
    func testDetailsView_RecoCollectionViewIsNotNil() {
        //Given
        sut.loadViewIfNeeded()
        viewModel.similarMovies = Box(value: [Movie(id: 1, title: "Evil Dead", poster_path: "evil.jpg", overview: "Esta si asista", vote_average: 8.0)])
        //When
        XCTAssertNotNil(sut.collectionView(sut.similarCV, numberOfItemsInSection: 0))
    }
    
    // MARK: - Pruebas de Collections Views
    
    func testDetailsView_SimilarCollectionViewIsNotNil() {
        //Given
        sut.loadViewIfNeeded()
        viewModel.recommendationMovies = Box(value: [Movie(id: 1, title: "Evil Dead", poster_path: "evil.jpg", overview: "Esta si asista", vote_average: 8.0)])
        //When
        XCTAssertNotNil(sut.collectionView(sut.recomendationsCV, numberOfItemsInSection: 0))
    }
    
    // MARK: - Pruebas Cast
    func testDetailsView_CastCollectionViewIsNotNil() {
        //Given
        sut.loadViewIfNeeded()
        viewModel.castMovie = Box(value: [Cast(id: 1 , name: "Pepe toño macias", profile_path: "", character: "Deadpool")])
        //When
        XCTAssertNotNil(sut.collectionView(sut.actorsCV, numberOfItemsInSection: 0))
    }
    
  // MARK: - Pruebas de mapas
    
    func testDetailsView_CinemaExist() {
        //Given
        sut.loadViewIfNeeded()
        sut.addCinema(lat: 19.99884, long: -19.99384)
        //When
        XCTAssertNotNil(sut.mapView.annotations.first?.coordinate)
    }
}
