//
//  ReviewMoviesRouter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation
import UIKit

final class ReviewMoviesRouter {
    
    weak var view: UIViewController?
    
    // Create a Search module VIPER
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "ReviewMovies", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "ReviewStory") as? ReviewMoviesViewController else {
            return UIViewController()
        }
        let movieApi = MovieAPI()
        let interactor = ReviewMoviesInteractor(movieAPI: movieApi)
        let router = ReviewMoviesRouter()
        let presenter = ReviewMoviesPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}

extension ReviewMoviesRouter: ReviewMoviesRouterProtocol {
    // Router pop a VC
    func popViewController() {
        self.view?.navigationController?.popViewController(animated: true)
    }
}
