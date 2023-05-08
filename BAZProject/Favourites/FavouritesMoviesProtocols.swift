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
    func showFavouriteMovies(movies: [Movie])
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
    func favouriteMovies()
    // Comunication between View and Presenter for pop VC
    func popViewController()
    
    func deleteFavouritesMovies()
}

protocol FavouriteMoviesInteractorOutputProtocol {
    /// interactor returns the movies obtained from the fecth
    /// - Parameters:
    ///    - movies: receive a [Movie]
    func presenterFavouriteMovies(moviesFavourite: [Movie])
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
    func favouriteMovies()
    
    func deleteFavouritesMovies()

}
