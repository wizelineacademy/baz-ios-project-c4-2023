//
//  HomeRouter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import Foundation
import UIKit

class HomeRouter {
    
    weak var view: UIViewController?
    
    // Create the mmodule Home with all the instances of VIPER
    static func createModule() -> UIViewController {
        let storyboard = UIStoryboard(name: "HomeMovies", bundle: nil)
        let view = storyboard.instantiateViewController(withIdentifier: "HomeMovies") as! HomeViewController
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        
        return view
    }
    
}


extension HomeRouter: HomeRouterProtocol {
    // Router push a VC that receive from Presenter
    func pushViewController(view: UIViewController) {
        self.view?.navigationController?.pushViewController(view, animated: true)
    }
}
