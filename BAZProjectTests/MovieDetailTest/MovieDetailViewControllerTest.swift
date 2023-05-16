//
//  MovieDetailViewControllerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import XCTest

@testable import BAZProject

final class MovieDetailViewControllerTest: XCTestCase {
    
    ///Sut
    var sut: MovieDetailViewController!
    
    ///Lista de Cast
    var casts: [Cast]!
    
    ///Lista de movies similares
    var similarMovies: [ListMovieProtocol]!
    
    ///Lista de movies recomendadas
    var recomendedMovies: [ListMovieProtocol]!
    
    ///movies recomendadas
    var movie: Movie = Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)
    
    ///Inicializador de las variables para las unit Test
    override func setUp() {
        sut = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        casts = [Cast(adult: true, gender: 1, id: 1, knownForDepartment: "", name: "", originalName: "", popularity: 2.0, creditID: "")]
        similarMovies = [movie]
        recomendedMovies = [movie]
        
    }
    
    ///Se  alimina la instancia de las variables para el test
    override func tearDown() {
        sut = nil
        casts = nil
        similarMovies = nil
        recomendedMovies = nil
    }
    
    ///se regresa el identidicador de la celda correctamente
    func test_cells_returnId(){
        let castId = "CastCollectionViewCell"
        let movieId = "MovieCollectionViewCell"
        XCTAssertEqual(castId, CastCollectionViewCell.idetifier)
        XCTAssertEqual(movieId, MovieCollectionViewCell.idetifier)
    }
    
    ///Test que evalua que la lista de peliculas se actualiza correctamente
    func test_set_Similar_into_collectionView(){
        sut.similarMovies = similarMovies
        
        sut.loadView()
        XCTAssertEqual(sut.collectionSimilar.numberOfItems(inSection: 0), 1)

    }
    
    ///Test que evalua que la lista de peliculas se actualiza correctamente
    func test_set_recommended_collectionView(){
        sut.recomendedMovies = recomendedMovies
        
        sut.loadView()
        XCTAssertEqual(sut.collectionRecomendation.numberOfItems(inSection: 0), 1)
        
    }
    
    ///Test que evalua que la lista de peliculas se actualiza correctamente
    func test_setCast_into_collectionView() {
        sut.cast = casts
        sut.loadView()
        XCTAssertEqual(sut.collectionCast.numberOfItems(inSection: 0), 1)
    }
    
    ///Test que evalua que la lista de peliculas se actualiza correctamente
    func test_setSimilar_setData() {
        sut.setSimilarMovies(movies: similarMovies)
        XCTAssertEqual(sut.similarMovies.count, similarMovies.count)
    }
    
    ///Test que evalua que la lista de peliculas se actualiza correctamente
    func test_setRecomended_setData() {
        sut.setRecomendedMovies(movies: similarMovies)
        XCTAssertEqual(sut.recomendedMovies.count, similarMovies.count)
    }
    
    ///Test que evalua que la lista del casting se actualiza correctamente
    func test_setCast_setData() {
        sut.setCast(casts)
        XCTAssertEqual(sut.cast.count, casts.count)
    }
    
    ///Test que evalua que la lista de reviews se actualiza correctamente
    func test_setReview_setData() {
        let autor = AuthorDetails(name: "ejemplo", username: "ejemplo")
        let review = [Review(author: "ejemplo", authorDetails: autor, content: "ejemplo", createdAt: "ejemplo", id: "ejemplo", updatedAt: "ejemplo", url: "ejemplo")]
        
        sut.setReviews(review)
        XCTAssertEqual(sut.reviews.count, review.count)
    }
    
    ///Test que evalua se pinte un favorito correctamete
    func test_setFavorite_setData(){
        sut.loadView()
        sut.setFavorite(true)
        let button = sut.btnLike
        
        XCTAssertEqual(button?.tintColor, .systemPink)
    }
    
    ///Test que evalua el metodo inicial de la vista se llama corectamente 
    func test_setUpInitialInfo_calls(){
        sut.loadView()
        sut.movie = movie
        sut.setUpInitialInfo()
        let textTilte = sut.lblTitle.text
        let textSub = sut.lblDescription.text
        
        XCTAssertEqual(textTilte, "ejemplo")
        XCTAssertEqual(textSub, "ejemplo")
    }
    
}
