//
//  MoviesDetailProtocol.swift
//  BAZProject
//
//  Created by nmorenoa on 25/04/23.
//

import UIKit

//MARK: - View
protocol MoviesDetailViewInputProtocol: AnyObject {
    
    var presenter   : MoviesDetailViewOutputProtocol? { get }
    
    func setInfoMovie(with movieData: MovieData?)
    func setReviews()
    func setRecomendations()
    func setSimilars()
    func setBtnLike(bsIsOn: Bool)
}

//MARK: - Presenter
protocol MoviesDetailViewOutputProtocol {
    
    var view            : MoviesDetailViewInputProtocol? { get }
    var interactor      : MoviesDetailInteractorInputProtocol? { get }
    var router          : MoviesDetailRouterProtocol? { get }
    var resultReviews   : [ReviewsMovieData] { get }
    var resultRecomendations : [InfoDetailData] { get }
    var resultSimilars       : [InfoDetailData] { get }
    
    func consultReviews()
    func getInfoFavoritesMovies()
    func addMovieToFavorite()
    
}

protocol MoviesDetailInteractorOutputProtocol: AnyObject {
    func setResponseDetailsMovies(with resultReviews: [ReviewsMovieData])
    func setResponseDetail(with result: [InfoDetailData], detail typeDetail: OptionDetail?)
    func setError()
    func showBtnFavorites(with bIsOn: Bool?)
}

// MARK: - Router
protocol MoviesDetailRouterProtocol {
    
    var view        : MoviesDetailView? { get }
    func presentAlert(_ alert: UIAlertController)
    
}

// MARK: - Interactor
protocol MoviesDetailInteractorInputProtocol {
    
    var presenter   : MoviesDetailInteractorOutputProtocol? { get }
    var moviesInfo  : MovieData? { get set }
    var bIsFavorite : Bool? { get set }
    
    func getInfo(detail typeDetail: OptionDetail?)
    func addFavoriteMovies()
    func getFavoriteMovies() -> Bool
    func removeFavoriteMovies()
    
}
