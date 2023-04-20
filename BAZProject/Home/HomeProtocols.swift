//  HomeProtocols.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

// MARK: - View (Presenter To View)
protocol HomeViewInputProtocol: AnyObject {
    var presenter: HomeViewOutputProtocol? { get }
    // MARK: - Functions
    func showViewDataMovies(movies: [ListMovieProtocol]?)
    //func showMoviesCount(count: Int)
}

// MARK: - Presenter

// MARK: - (View To Presenter)
protocol HomeViewOutputProtocol {
    var view: HomeViewInputProtocol? { get }
    var interactor: HomeInteractorInputProtocol { get }
    var router: HomeRouterProtocol { get }
    var labelTitle: String { get }
    // MARK: - Functions
    func getDataMovies()
    func getMoviesCount() -> Int
    func getMovieDescription(index: Int) -> String?
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
}

// MARK: - (Interactor To Presenter)
protocol HomeInteractorOutputProtocol: AnyObject {
    // MARK: - Functions
    func presentDataMovies(movies: [ListMovieProtocol]?)
    func presentMoviesCount(count: Int)
}

// MARK: - Router (Presenter To Router)
protocol HomeRouterProtocol {
    var view: UIViewController? { get }
}

// MARK: - Interactor (Presenter To Interactor)
protocol HomeInteractorInputProtocol {
    var presenter: HomeInteractorOutputProtocol? { get }
    var labelTitle: String { get }
    // MARK: - Functions
    func getDataMovies()
    func getMoviesCount() -> Int
    func getMovieDescription(index: Int) -> String?
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
    
}
