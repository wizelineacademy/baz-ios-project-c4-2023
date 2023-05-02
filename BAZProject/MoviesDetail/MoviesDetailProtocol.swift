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
}

//MARK: - Presenter
protocol MoviesDetailViewOutputProtocol {
    
    var view            : MoviesDetailViewInputProtocol? { get }
    var interactor      : MoviesDetailInteractorInputProtocol? { get }
    var router          : MoviesDetailRouterProtocol? { get }
    var resultReviews   : [ReviewsMovieData] { get }
    var resultRecomendations : [RecomendationsData] { get }
    
    func consultReviews()
    
}

protocol MoviesDetailInteractorOutputProtocol: AnyObject {
    func setResponseDetailsMovies(with resultReviews: [ReviewsMovieData])
    func setResponseRecomendations(with result: [RecomendationsData])
    func setError()
}

// MARK: - Router
protocol MoviesDetailRouterProtocol {
    
    var view        : MoviesDetailView? { get }
    
}

// MARK: - Interactor
protocol MoviesDetailInteractorInputProtocol {
    
    var presenter   : MoviesDetailInteractorOutputProtocol? { get }
    var moviesInfo  : MovieData? { get set }
    
    func getReview()
    func getRecomendations()
    
}
