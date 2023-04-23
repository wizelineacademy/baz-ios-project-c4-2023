//
//  HomeProtocols.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import UIKit

// HomeViewInputProtocol o HomePresenterToViewProtocol
// MARK: - View
protocol HomeViewInputProtocol: AnyObject {
    var presenter: HomeViewOutputProtocol? { get }
    // Presenter return information to view
    func showCategories(movies: [MovieProtocol], section: Int)
    
}

// MARK: - Presenter

protocol HomeViewOutputProtocol: AnyObject {
    var view: HomeViewInputProtocol? { get }
    var interactor: HomeInteractorInputProtocol { get }
    var router: HomeRouterProtocol { get }
    
    // View fetch information to presenter
    func fetchCategories(url: String, section: Int)
    // View communicates to presenter that want to present another view
    func pushViewController(view: UIViewController)
}

protocol HomeInteractorOutputProtocol {
    // Interactor return information of the fetch to pressnter
    func presenterCategories(movies: [MovieProtocol], section: Int)
    
}

// MARK: - Router
protocol HomeRouterProtocol {
    var view: UIViewController? { get }
    // Router receive a view to push them
    func pushViewController(view: UIViewController)
}

// MARK: - Interactor
protocol HomeInteractorInputProtocol {
    var presenter: HomeInteractorOutputProtocol? { get }
    // Interactor receive a fecth from presenter
    func fetchCategories(url: String, section: Int)
    
}