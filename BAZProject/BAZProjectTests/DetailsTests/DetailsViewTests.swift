//
//  DetailsViewTests.swift
//  BAZProject
//
//  Created by Manuel S on 04/05/23.
//

import XCTest
@testable import BAZProject

final class DetailsViewTests: XCTestCase {
    
    var sut: DetailsView!
    var viewModel = DetailsViewModel(movieDetail: Movie(id: 1, title: "Evil Dead", poster_path: "evil.jpg", overview: "Esta si asista", vote_average: 8.0))
    
    
    override func setUp(){
        super.setUp()
        sut = DetailsView(ViewModel: viewModel)
        sut.ViewModel = viewModel
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    //MARK: - Pruebas de pantalla principal
    
    func testDetailsView_TitleIsEqualToViewModel(){
        //Given
        sut.loadViewIfNeeded()
        //When
        XCTAssertEqual(sut.navigationItem.title, viewModel.getTitle())
    }
    
    func testDetailsView_MovieIsNotFavorite(){
        //Given
        sut.loadViewIfNeeded()
        let favorite = viewModel.isMovieFavorite()
        //When
        XCTAssertFalse(favorite)
    }
    
    func testDetailsView_onViewIsNotNil(){
        //Given
        sut.loadViewIfNeeded()
        let favorite = sut.favoriteButton.title(for: .normal)
        //When
        XCTAssertEqual(favorite, "Agregar")
    }
    
    //Pruebas Peliculas Similares
    
    func testDetailsView_RecoCollectionViewIsNotNil(){
        //Given
        sut.loadViewIfNeeded()
        viewModel.similarMovies = Box(value: [Movie(id: 1, title: "Evil Dead", poster_path: "evil.jpg", overview: "Esta si asista", vote_average: 8.0)])
        //When
        XCTAssertNotNil(sut.collectionView(sut.similarCV, numberOfItemsInSection: 0))
    }
    
    //MARK: - Pruebas de Collections Views
    
    //Prueba Peliculas Recomendadas
    
    func testDetailsView_SimilarCollectionViewIsNotNil(){
        //Given
        sut.loadViewIfNeeded()
        viewModel.recommendationMovies = Box(value: [Movie(id: 1, title: "Evil Dead", poster_path: "evil.jpg", overview: "Esta si asista", vote_average: 8.0)])
        //When
        XCTAssertNotNil(sut.collectionView(sut.recomendationsCV, numberOfItemsInSection: 0))
    }
    
    //Pruebas Cast
    
    func testDetailsView_CastCollectionViewIsNotNil(){
        //Given
        sut.loadViewIfNeeded()
        viewModel.castMovie = Box(value: [Cast(id: 1 , name: "Pepe toño macias", profile_path: "", character: "Deadpool")])
        //When
        XCTAssertNotNil(sut.collectionView(sut.actorsCV, numberOfItemsInSection: 0))
    }
    
    
    
}
