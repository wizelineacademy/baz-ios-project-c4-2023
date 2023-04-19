//  HomeRouter.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.
//  
//  ViperTemplate v.0.0.1 - (2023, NS-Bionick Development Team)

import UIKit

class HomeRouter {
    weak var view: UIViewController?
    
    static func createModule() -> UIViewController {
        let view = HomeViewController()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        let presenter = HomePresenter(view: view, interactor: interactor, router: router)
        view.presenter = presenter
        interactor.presenter = presenter
        router.view = view
        return view
        /*let view = HomeViewController()
        let presenter = HomePresenter()
        let interactor = HomeInteractor()
        let router = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        presenter.router = router
        interactor.presenter = presenter
        
        return view*/
    }
}

extension HomeRouter: HomeRouterProtocol {
    
}
