//
//  SearchMoviesRouter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation
import UIKit

final class SearchMoviesRouter {
    
    weak var view: UIViewController?
    
    // Create a Search module VIPER
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "SearchMovies", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "SearchStory") as? SearchMoviesViewController else {
            return UIViewController()
        }
        let movieApi = MovieAPI()
        let interactor = SearchMoviesInteractor(movieAPI: movieApi)
        let router = SearchMoviesRouter()
        let presenter = SearchMoviesPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}

extension SearchMoviesRouter: SearchMoviesRouterProtocol {
    // Router pop a VC
    func popViewController() {
        self.view?.navigationController?.popViewController(animated: true)
    }
}
