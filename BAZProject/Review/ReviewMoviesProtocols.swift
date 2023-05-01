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
    // Movies that return the ftch to be showed
    func showReviewMovies(movie: MovieProtocol)
}

// MARK: - Presenter

protocol ReviewMoviesViewOutputProtocol: AnyObject {
    var view: ReviewMoviesViewInputProtocol? { get }
    var interactor: ReviewMoviesInteractorInputProtocol { get }
    var router: ReviewMoviesRouterProtocol { get }
    /// Comunication between View and Presenter for fecth movies
    /// - Parameters:
    ///    - url: a String url fetch
    ///    - key: a String to be searched
    func reviewMovies(idMovie: String)
    // Comunication between View and Presenter for pop VC
    func popViewController()
}

protocol ReviewMoviesInteractorOutputProtocol {
    /// interactor returns the movies obtained from the fecth
    /// - Parameters:
    ///    - movies: receive a [MovieProtocol]
    func presenterReviewMovies(movieReview: MovieProtocol)
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
    /// Comunication between Presenter and Interactor for fecth movies
    /// - Parameters:
    ///    - url: a String url fetch
    ///    - key: a String to be searched
    func reviewMovies(idMovie: String)
}
