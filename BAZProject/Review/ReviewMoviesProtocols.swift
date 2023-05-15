//
//  ReviewMoviesProtocols.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import UIKit

// ReviewMoviesViewInputProtocol o ReviewMoviesPresenterToViewProtocol
// MARK: - View
protocol ReviewMoviesViewInputProtocol: AnyObject {
    var presenter: ReviewMoviesViewOutputProtocol? { get }
    // Review that return the fetch
    func showReviewMovies(movie: MovieReview)
    // Similar Movies that return the fetch to be showed
    func showSimilarMovies(similarMovies: [Movie])
    // Recomended Movies that return the fetch to be showed
    func showRecomendedMovies(recomendedMoviess: [Movie])
}

// MARK: - Presenter

protocol ReviewMoviesViewOutputProtocol: AnyObject {
    var view: ReviewMoviesViewInputProtocol? { get }
    var interactor: ReviewMoviesInteractorInputProtocol { get }
    var router: ReviewMoviesRouterProtocol { get }
    /// Comunication between View and Presenter for fecth review movies
    /// - Parameters:
    ///    - url: a URL to fetch
    func reviewMovies(url: String)
    /// Comunication between View and Presenter for fecth similar movies
    /// - Parameters:
    ///    - url: a URL to fetch
    func similarMovies(url: String)
    /// Comunication between View and Presenter for fecth recomended movies
    /// - Parameters:
    ///    - url: a URL to fetch
    func recomendedMovies(url: String)
    // Comunication between View and Presenter for pop VC
    func popViewController()
}

protocol ReviewMoviesInteractorOutputProtocol {
    /// interactor returns the review obtained from the fecth
    /// - Parameters:
    ///    - review: receive a [Movie]
    func presenterReviewMovies(movieReview: MovieReview)
    /// interactor returns the similar movies obtained from the fecth
    /// - Parameters:
    ///    - review: receive a [Movie]
    func presenterSimiliarMovies(similarMovies: [Movie])
    /// interactor returns the recomended movies obtained from the fecth
    /// - Parameters:
    ///    - review: receive a [Movie]
    func presenterRecomendedMovies(recomendedMoviess: [Movie])
}

// MARK: - Router
protocol ReviewMoviesRouterProtocol {
    var view: UIViewController? { get }
    // Presenter want to Router pop a VC
    func popViewController()
}

// MARK: - Interactor
protocol ReviewMoviesInteractorInputProtocol {
    var presenter: ReviewMoviesInteractorOutputProtocol? { get }
    /// Comunication between View and Presenter for fecth review movies
    /// - Parameters:
    ///    - url: a URL to fetch
    func reviewMovies(url: String)
    /// Comunication between View and Presenter for fecth similar movies
    /// - Parameters:
    ///    - url: a URL to fetch
    func similarMovies(url: String)
    /// Comunication between View and Presenter for fecth recomended movies
    /// - Parameters:
    ///    - url: a URL to fetch
    func recomendedMovies(url: String)
}
