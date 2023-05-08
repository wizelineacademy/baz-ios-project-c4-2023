//  SearchRouter.swift
//  BAZProject
//
//  Created by jehernandezg on 20/04/23.

import UIKit

// MARK: - Class
class SearchRouter {
    // MARK: - Properties
    weak var view: UIViewController?
    private var animationView: UIAlertController?
    
    // MARK: - Functions
    
    /// Create the search module
    /// - Returns: The search module
    static func createModule() -> UIViewController {
        let view = SearchViewController()
        let interactor = SearchInteractor()
        let router = SearchRouter()
        let presenter = SearchPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }
}

// MARK: - Extensions
extension SearchRouter: SearchRouterProtocol {
    // MARK: - Functions
    
    /// Show the animation alert from service
    /// - Parameter completion: The implementation while showing animation alert
    func showAnimation(completion: @escaping () -> Void) {
        animationView = UIAlertController.GlobalViews.animationView
        DispatchQueue.main.async {
            self.view?.present(self.animationView ?? UIAlertController(), animated: true, completion: {
                completion()
            })
        }
    }
    
    
    /// Hide the animation alert from service
    /// - Parameter completion: Finish the animation
    func hideAnimation(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.animationView?.dismiss(animated: true, completion: completion)
        }
    }
    
    
    /// Show the Detail module
    /// - Parameter movie: The data of selected movie
    func showDetail(movie: ListMovieProtocol) {
        let viewController = DetailRouter.createModule(withMovie: movie)
        self.view?.navigationController?.pushViewController(viewController, animated: true)
    }
    
}
