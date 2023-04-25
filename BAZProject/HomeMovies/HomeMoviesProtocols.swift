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
    /// View communicates to presenter that want to present another view
    /// - Parameters:
    ///    - view: receive a view to be pushed
    func pushSearchViewController(view: UIViewController)
}

protocol HomeInteractorOutputProtocol {
    /// Interactor return information of the fetch to pressnter
    /// - Parameters:
    ///   - movies: a [MovieProtocol]
    ///   - section: the section where the information will be displayed
    func presenterCategories(movies: [MovieProtocol], section: Int)
    
}

// MARK: - Router
protocol HomeRouterProtocol {
    var view: UIViewController? { get }
    // Router receive a view to push them
    func pushSearchViewController(view: UIViewController)
}

// MARK: - Interactor
protocol HomeInteractorInputProtocol {
    var presenter: HomeInteractorOutputProtocol? { get }
    /// Interactor receive a fecth from presenter
    /// - Parameters:
    ///   - movies: a String url fetch
    ///   - section: the section where the information will be displayed
    func fetchCategories(url: String, section: Int)
    
}
