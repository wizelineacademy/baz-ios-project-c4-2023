//
//  DetailRouter.swift
//  BAZProject
//
//  Created by jehernandezg on 03/05/23.
//

import UIKit

// MARK: - Class
class DetailRouter {
    // MARK: - Properties
    weak var view: UIViewController?
    
    // MARK: - Functions
    
    /// Create the Detail module
    /// - Parameter movie: The data of selected movie
    /// - Returns: return the Detail ViewController
    static func createModule(withMovie movie: ListMovieProtocol) -> UIViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view, interactor: interactor, router: router, detailMovie: movie)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }
}

// MARK: - Extensions
extension DetailRouter: DetailRouterProtocol {
    
}

