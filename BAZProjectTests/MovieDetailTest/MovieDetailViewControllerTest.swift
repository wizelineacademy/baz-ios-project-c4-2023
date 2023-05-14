//
//  MovieDetailViewControllerTest.swift
//  BAZProjectTests
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import XCTest

@testable import BAZProject

final class MovieDetailViewControllerTest: XCTestCase {
    
    var sut: MovieDetailViewController!
    var casts: [Cast]!
    var similarMovies: [ListMovieProtocol]!
    var recomendedMovies: [ListMovieProtocol]!
    var movie: Movie = Movie(id: 1, title: "ejemplo", posterPath: "ejemplo", adult: false, backdropPath: "ejemplo", genreIDS: [1,2,3], originalLanguage: "ejemplo", originalTitle: "ejemplo", overview: "ejemplo", popularity: 90.0, releaseDate: "ejemplo", video: false, voteAverage: 9.0, voteCount: 10)
    
    override func setUp() {
        sut = MovieDetailViewController(nibName: "MovieDetailViewController", bundle: nil)
        casts = [Cast(adult: true, gender: 1, id: 1, knownForDepartment: "", name: "", originalName: "", popularity: 2.0, creditID: "")]
        similarMovies = [movie]
        recomendedMovies = [movie]
        
    }
    
    override func tearDown() {
        sut = nil
    }
    
    func test_cells_returnId(){
        let castId = "CastCollectionViewCell"
        let movieId = "MovieCollectionViewCell"
        XCTAssertEqual(castId, CastCollectionViewCell.idetifier)
        XCTAssertEqual(movieId, MovieCollectionViewCell.idetifier)
    }
    
    func test_set_Similar_into_collectionView(){
        sut.similarMovies = similarMovies
        
        sut.loadView()
        XCTAssertEqual(sut.collectionSimilar.numberOfItems(inSection: 0), 1)

    }
    
    func test_set_recommended_collectionView(){
        sut.recomendedMovies = recomendedMovies
        
        sut.loadView()
        XCTAssertEqual(sut.collectionRecomendation.numberOfItems(inSection: 0), 1)
        
    }
    
    func test_setCast_into_collectionView() {
        sut.cast = casts
        sut.loadView()
        XCTAssertEqual(sut.collectionCast.numberOfItems(inSection: 0), 1)
    }
    
    func test_setSimilar_setData() {
        sut.setSimilarMovies(movies: similarMovies)
        XCTAssertEqual(sut.similarMovies.count, similarMovies.count)
    }
    
    func test_setRecomended_setData() {
        sut.setRecomendedMovies(movies: similarMovies)
        XCTAssertEqual(sut.recomendedMovies.count, similarMovies.count)
    }
    
    func test_setCast_setData() {
        sut.setCast(casts)
        XCTAssertEqual(sut.cast.count, casts.count)
    }
    
    func test_setReview_setData() {
        let autor = AuthorDetails(name: "ejemplo", username: "ejemplo")
        let review = [Review(author: "ejemplo", authorDetails: autor, content: "ejemplo", createdAt: "ejemplo", id: "ejemplo", updatedAt: "ejemplo", url: "ejemplo")]
        
        sut.setReviews(review)
        XCTAssertEqual(sut.reviews.count, review.count)
    }
    
    func test_setFavorite_setData(){
        sut.loadView()
        sut.setFavorite(true)
        let button = sut.btnLike
        
        XCTAssertEqual(button?.tintColor, .systemPink)
    }
    
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
