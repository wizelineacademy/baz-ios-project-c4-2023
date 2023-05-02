//  HomeProtocols.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

// MARK: - View (Presenter To View)
protocol HomeViewInputProtocol: AnyObject {
    // MARK: - Properties
    var presenter: HomeViewOutputProtocol? { get }
    // MARK: - Functions
    func showViewDataMovies(movies: [ListMovieProtocol]?)
}

// MARK: - Presenter

// MARK: - (View To Presenter)
protocol HomeViewOutputProtocol {
    // MARK: - Properties
    var view: HomeViewInputProtocol? { get }
    var interactor: HomeInteractorInputProtocol { get }
    var router: HomeRouterProtocol { get }
    // MARK: - Functions
    func getDataMovies(endPoint: Endpoint)
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

// MARK: - (Interactor To Presenter)
protocol HomeInteractorOutputProtocol: AnyObject {
    // MARK: - Functions
    func presentDataMovies(movies: [ListMovieProtocol]?)
}

// MARK: - Router (Presenter To Router)
protocol HomeRouterProtocol {
    var view: UIViewController? { get }
    func showAnimation(completion: @escaping () -> Void)
    func hideAnimation(completion: @escaping () -> Void)
}

// MARK: - Interactor (Presenter To Interactor)
protocol HomeInteractorInputProtocol {
    // MARK: - Properties
    var presenter: HomeInteractorOutputProtocol? { get }
    // MARK: - Functions
    func getDataMovies(endPoint: Endpoint, completion: @escaping () -> Void)
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
}
