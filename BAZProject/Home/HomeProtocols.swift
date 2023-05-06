//  HomeProtocols.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

// MARK: - V I E W (Presenter To View)
protocol HomeViewInputProtocol: AnyObject {
    // MARK: - Properties
    var presenter: HomeViewOutputProtocol? { get }
    // MARK: - Functions
    func showViewDataMovies(movies: [ListMovieProtocol]?)
}

// MARK: - P R E S E N T E R (View To Presenter)
protocol HomeViewOutputProtocol {
    // MARK: - Properties
    var view: HomeViewInputProtocol? { get }
    var interactor: HomeInteractorInputProtocol { get }
    var router: HomeRouterProtocol { get }
    // MARK: - Functions
    func getDataMovies(endPoint: Endpoint)
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
    func saveFavorite(index: Int)
    func deleteFavorite(index: Int)
    func showSearchModule()
}

// MARK: - P R E S E N T E R (Interactor To Presenter)
protocol HomeInteractorOutputProtocol: AnyObject {
    // MARK: - Functions
    func presentDataMovies(movies: [ListMovieProtocol]?)
}

// MARK: - I N T E R A C T O R (Presenter To Interactor)
protocol HomeInteractorInputProtocol: MainInteractorProtocol {
    // MARK: - Properties
    var presenter: HomeInteractorOutputProtocol? { get }
    // MARK: - Functions
    func getDataMovies(endPoint: Endpoint, completion: @escaping () -> Void)
}

// MARK: - R O U T E R (Presenter To Router)
protocol HomeRouterProtocol {
    var view: UIViewController? { get }
    func showAnimation(completion: @escaping () -> Void)
    func hideAnimation(completion: @escaping () -> Void)
    func showSearchModule()
}
