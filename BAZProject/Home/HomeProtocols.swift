//  HomeProtocols.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

// MARK: - View
//HomePresenterToViewProtocol
protocol HomeViewInputProtocol: AnyObject {
    var presenter: HomeViewOutputProtocol? { get }
    // MARK: - Functions
}

// MARK: - Presenter
//HomeViewToPresenterProtocol
protocol HomeViewOutputProtocol {
    var view: HomeViewInputProtocol? { get }
    var interactor: HomeInteractorInputProtocol { get }
    var router: HomeRouterProtocol { get }
    var labelTitle: String { get }
    // MARK: - Functions
    func getDataMovies(_ completion: @escaping () -> Void)
    func getMoviesCount() -> Int
    func getMovieDescription(index: Int) -> String?
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
    
}

//HomeInteractorToPresenterProtocol
protocol HomeInteractorOutputProtocol: AnyObject {
    // MARK: - Functions
}

// MARK: - Router
//HomePresenterToRouterProtocol
protocol HomeRouterProtocol {
    var view: UIViewController? { get }
}

// MARK: - Interactor
//HomePresenterToInteractorProtocol
protocol HomeInteractorInputProtocol {
    // MARK: - Functions
    var presenter: HomeInteractorOutputProtocol? { get }
    var labelTitle: String { get }
    func getDataMovies(_ completion: @escaping () -> Void)
    func getMoviesCount() -> Int
    func getMovieDescription(index: Int) -> String?
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void)
    
}
