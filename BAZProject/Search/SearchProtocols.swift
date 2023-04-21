//  SearchProtocols.swift
//  BAZProject
//
//  Created by jehernandezg on 20/04/23.

import UIKit

// MARK: - View (Presenter To View)
protocol SearchViewInputProtocol: AnyObject {
    // MARK: - Properties
    var presenter: SearchViewOutputProtocol? { get }
    // MARK: - Functions
    func showViewDataMovies(movies: [ListMovieProtocol]?)
}

// MARK: - Presenter

// MARK: - (View To Presenter)
protocol SearchViewOutputProtocol {
    // MARK: - Properties
	var view: SearchViewInputProtocol? { get }
	var interactor: SearchInteractorInputProtocol { get }
	var router: SearchRouterProtocol { get }
    // MARK: - Functions
    func getMovieSearch(movieName: String)
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

// MARK: - (Interactor To Presenter)
protocol SearchInteractorOutputProtocol: AnyObject {
    // MARK: - Functions
    func presentDataMovies(movies: [ListMovieProtocol]?)
}

// MARK: - Interactor (Presenter To Interactor)
protocol SearchInteractorInputProtocol {
    // MARK: - Properties
    var presenter: SearchInteractorOutputProtocol? { get }
    // MARK: - Functions
    func getMovieSearch(movieName: String)
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

// MARK: - Router (Presenter To Router)
protocol SearchRouterProtocol {
    var view: UIViewController? { get }
}
