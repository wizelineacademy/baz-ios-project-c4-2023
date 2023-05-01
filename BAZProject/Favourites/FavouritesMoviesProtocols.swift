//
//  FavouriteMoviesProtocols.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import UIKit

// FavouriteMoviesViewInputProtocol o FavouriteMoviesPresenterToViewProtocol
// MARK: - View
protocol FavouriteMoviesViewInputProtocol: AnyObject {
    var presenter: FavouriteMoviesViewOutputProtocol? { get }
    // Movies that return the ftch to be showed
    func showFavouriteMovies(movie: MovieProtocol)
}

// MARK: - Presenter

protocol FavouriteMoviesViewOutputProtocol: AnyObject {
    var view: FavouriteMoviesViewInputProtocol? { get }
    var interactor: FavouriteMoviesInteractorInputProtocol { get }
    var router: FavouriteMoviesRouterProtocol { get }
    /// Comunication between View and Presenter for fecth movies
    /// - Parameters:
    ///    - url: a String url fetch
    ///    - key: a String to be searched
    func FavouriteMovies(idMovie: String)
    // Comunication between View and Presenter for pop VC
    func popViewController()
}

protocol FavouriteMoviesInteractorOutputProtocol {
    /// interactor returns the movies obtained from the fecth
    /// - Parameters:
    ///    - movies: receive a [MovieProtocol]
    func presenterFavouriteMovies(movieFavourite: MovieProtocol)
}

// MARK: - Router
protocol FavouriteMoviesRouterProtocol {
    var view: UIViewController? { get }
    // Presenter want to Router pop a VC
    func popViewController()
}

// MARK: - Interactor
protocol FavouriteMoviesInteractorInputProtocol {
    var presenter: FavouriteMoviesInteractorOutputProtocol? { get }
    /// Comunication between Presenter and Interactor for fecth movies
    /// - Parameters:
    ///    - url: a String url fetch
    ///    - key: a String to be searched
    func FavouriteMovies(idMovie: String)
}
