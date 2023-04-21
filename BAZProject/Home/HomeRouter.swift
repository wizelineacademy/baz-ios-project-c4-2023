//  HomeRouter.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.
//  
//  ViperTemplate v.0.0.1 - (2023, NS-Bionick Development Team)

import UIKit

// MARK: - Class
class HomeRouter {
    // MARK: - Properties
    weak var view: UIViewController?
    
    // MARK: - Functions
    static func createModule() -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
    }
}

// MARK: - Extensions
extension HomeRouter: HomeRouterProtocol {
    
}
