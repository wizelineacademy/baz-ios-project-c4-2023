//
//  MovieDetailsProtocols.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//  
//

import Foundation
import UIKit

//MARK: - View

/// Presenter -> View
protocol MovieDetailsViewProtocol: AnyObject {
    var presenter: MovieDetailsPresenterProtocol? { get set }
    
    func setNavigationTitle(for strTitle: String?)
    func showMovieData(_ movie: MovieDetailsInfo, castDescription: String?)
    func updateMovieCast(_ castDescription: String?)
    func updateBackdropImage(_ image: UIImage)
    func showMovieReviews(_ reviews: [MovieReviewInfo])
    func showSimilarMovies(_ movies: [MovieInfo])
    func showRecommendedMovies(_ movies: [MovieInfo])
    func setFavoriteMovieIcon(to isFavorite: Bool)
}

//MARK: - Interactor

/// Interactor -> Presenter
protocol MovieDetailsInteractorOutputProtocol: AnyObject {
    func presentMovieDetails(_ movie: MovieDetailsInfo?)
    func presentMovieCredits(_ credits: MovieCreditsInfo?)
    func presentMovieBackdropImage(_ image: UIImage?)
    func presentMovieReviews(_ reviews: [MovieReviewInfo]?)
    func presentSimilarMovies(_ movies: [MovieInfo]?)
    func presentRecommendations(_ movies: [MovieInfo]?)
    func presentFavoriteMovie(_ isFavorite: Bool)
}

/// Presenter -> Interactor
protocol MovieDetailsInteractorInputProtocol: AnyObject {
    var presenter: MovieDetailsInteractorOutputProtocol? { get set }
    var entity: MovieDetailsEntity? { get set }
    var movie: MovieDetailsInfo? { get set }
    
    func getNavTitle() -> String?
    func verifyFavorite()
    func fetchMovieDetails()
    func downloadBackdropImage(with path: String)
    func fetchMovieReviews()
    func fetchSimilarMovies()
    func fetchRecommendations()
    func saveToFavorites()
    func removeFromFavorites()
    
    // TODO: getters for similar, review and recommendations
}

//MARK: - Presenter

/// View -> Presenter
protocol MovieDetailsPresenterProtocol: AnyObject {
    var view: MovieDetailsViewProtocol? { get set }
    var interactor: MovieDetailsInteractorInputProtocol? { get set }
    var router: MovieDetailsRouterProtocol? { get set }
    
    func viewDidLoad()
    func attach(view: MovieDetailsViewProtocol?)
    func present()
    func getBackdropImage(with path: String?)
    func showReviewSection()
    func showSimilarMoviesSection()
    func showRecommendationsSection()
    func saveToFavorites()
    func removeFromFavorites()
    
    func goToMovieDetails(for movieID: Int)
}

//MARK: - Router

/// Presenter -> Router
protocol MovieDetailsRouterProtocol: AnyObject {
    func present(presenter: MovieDetailsPresenterProtocol)
    func goToMovieDetailsView(_ movie: MovieInfo, parent: MovieDetailsViewProtocol?)
    func popView()
}
