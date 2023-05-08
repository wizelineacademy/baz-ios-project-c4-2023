//
//  HomePresenter.swift
//  DemoVIPER
//
//  Created by ksolano on 13/04/23.
//

import UIKit

final class HomePresenter {
    
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
    /// call to intercator for set one movie to favs
    func storeFav(movieFav: Movie) {
        interactor.storeFav(movieFav: movieFav)
    }
    
    func pushSearchViewController(view: UIViewController) {
        /// conection between view and presenter for push a Search VC
        /// - Parameters:
        ///    - view: receive a view to be pushed
        router.pushSearchViewController(view: view)
    }
    
    func fetchCategories(url: String, section: Int) {
        /// Conection between view and presenter to get a interactor fetch
        /// - Parameters:
        ///   - url: a String url fetch
        ///   - section: the section where the information will be displayed
        interactor.fetchCategories(url: url, section: section)
    }
    
    
}

extension HomePresenter: HomeInteractorOutputProtocol {
    func presenterCategories(movies: [Movie], section: Int) {
        /// Conection between interactor and presenter to share movie information to the view
        /// - Parameters:
        ///   - movies: a [Movie]
        ///   - section: the section where the information will be displayed
        view?.showCategories(movies: movies, section: section)
    }
    
    
}
