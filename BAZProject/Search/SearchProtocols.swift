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

// MARK: - Presenter (View To Presenter)
protocol SearchViewOutputProtocol {
    // MARK: - Properties
	var view: SearchViewInputProtocol? { get }
	var interactor: SearchInteractorInputProtocol { get }
	var router: SearchRouterProtocol { get }
    // MARK: - Functions
    func getMovieSearch(endPoint: Endpoint)
    func getMovieImage(imagePath: String, completion: @escaping (UIImage?) -> Void)
    func saveFavorite(index: Int)
    func deleteFavorite(index: Int)
    func showDetailModule(movie: ListMovieProtocol)
}

// MARK: - (Interactor To Presenter)
protocol SearchInteractorOutputProtocol: AnyObject {
    // MARK: - Functions
    func presentDataMovies(movies: [ListMovieProtocol]?)
}

// MARK: - Interactor (Presenter To Interactor)
protocol SearchInteractorInputProtocol: MainInteractorProtocol {
    // MARK: - Properties
    var presenter: SearchInteractorOutputProtocol? { get }
    // MARK: - Functions
    func getMovieSearch(endPoint: Endpoint, completion: @escaping () -> Void)
}

// MARK: - Router (Presenter To Router)
protocol SearchRouterProtocol {
    var view: UIViewController? { get }
    func showAnimation(completion: @escaping () -> Void)
    func hideAnimation(completion: @escaping () -> Void)
    func showDetail(movie: ListMovieProtocol)
}
