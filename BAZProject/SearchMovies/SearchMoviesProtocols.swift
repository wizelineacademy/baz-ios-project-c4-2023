//
//  SearchMoviesProtocols.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import UIKit

// SearchMoviesViewInputProtocol o SearchMoviesPresenterToViewProtocol
// MARK: - View
protocol SearchMoviesViewInputProtocol: AnyObject {
    var presenter: SearchMoviesViewOutputProtocol? { get }
    // Movies that return the ftch to be showed
    func showSearchMovies(movies: [MovieProtocol])
}

// MARK: - Presenter

protocol SearchMoviesViewOutputProtocol: AnyObject {
    var view: SearchMoviesViewInputProtocol? { get }
    var interactor: SearchMoviesInteractorInputProtocol { get }
    var router: SearchMoviesRouterProtocol { get }
    // Comunication between View and Presenter for fecth movies
    func searchMovies(url: String, key: String)
    // Comunication between View and Presenter for pop VC
    func popViewController()
}

protocol SearchMoviesInteractorOutputProtocol {
    // interactor returns the movies obtained from the fecth
    func presenterSearchMovies(movies: [MovieProtocol])
}

// MARK: - Router
protocol SearchMoviesRouterProtocol {
    var view: UIViewController? { get }
    // Presenter want to Router pop a VC
    func popViewController()
}

// MARK: - Interactor
protocol SearchMoviesInteractorInputProtocol {
    var presenter: SearchMoviesInteractorOutputProtocol? { get }
    // Comunication between Presenter and Interactor for fecth a movies from a url and a key
    func searchMovies(url: String, key: String)
}
