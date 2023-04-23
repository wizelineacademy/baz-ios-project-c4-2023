//
//  HomePresenter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import UIKit

class HomePresenter {
    
    // MARK: properties
    weak var view: HomeViewInputProtocol?
    var interactor: HomeInteractorInputProtocol
    var router: HomeRouterProtocol
    
    init(view: HomeViewInputProtocol, interactor: HomeInteractorInputProtocol, router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

extension HomePresenter: HomeViewOutputProtocol {
    func pushViewController(view: UIViewController) {
        // conection between view and presnter for push a VC
        router.pushViewController(view: view)
    }
    
    func fetchCategories(url: String, section: Int) {
        // Conection between view and presenter to get a interactor fetch
        interactor.fetchCategories(url: url, section: section)
    }
    
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func presenterCategories(movies: [MovieProtocol], section: Int) {
        // Conection between interactor and presenter to share movie information to the view
        view?.showCategories(movies: movies, section: section)
    }
    
    
}
