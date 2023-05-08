//
//  HomeRouter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation
import UIKit

final class HomeRouter {
    
    weak var view: UIViewController?
    
    // Create the mmodule Home with all the instances of VIPER
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "HomeMovies", bundle: nil)
        guard let view = storyboard.instantiateViewController(withIdentifier: "HomeMovies") as? HomeViewController else {
            return UIViewController()
        }
        
        let movieApi = MovieAPI()
        let favouriteManager = FavouriteManager()
        let interactor = HomeInteractor(movieAPI: movieApi, favouriteManager: favouriteManager)
        let router = HomeRouter()
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
}


extension HomeRouter: HomeRouterProtocol {
    /// Router push a Search VC that receive from Presenter
    /// - Parameters:
    ///    - view: receive a view to be pushed
    func pushSearchViewController(view: UIViewController) {
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
