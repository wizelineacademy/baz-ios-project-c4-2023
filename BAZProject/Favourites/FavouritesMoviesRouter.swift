//
//  FavouriteMoviesRouter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation
import UIKit

final class FavouriteMoviesRouter {
    
    weak var view: UIViewController?
    
    // Create a Search module VIPER
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "FavouritesMovies", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "FavouriteStory") as? FavouriteMoviesViewController else {
            return UIViewController()
        }
        let favouriteManager = FavouriteManager()
        let movieApi = MovieAPI()
        let interactor = FavouriteMoviesInteractor(movieAPI: movieApi, favouriteManager: favouriteManager)
        let router = FavouriteMoviesRouter()
        let presenter = FavouriteMoviesPresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
}

extension FavouriteMoviesRouter: FavouriteMoviesRouterProtocol {
    // Router pop a VC (Home ViewController)
    func popViewController() {
        self.view?.navigationController?.popViewController(animated: true)
    }
}
