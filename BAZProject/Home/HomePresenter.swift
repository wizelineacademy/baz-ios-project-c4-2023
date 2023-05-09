//  HomePresenter.swift
//  BAZProject
//
//  Created by jehernandezg on 18/04/23.

import UIKit

// MARK: - Class
class HomePresenter {
    // MARK: - Properties
    weak var view: HomeViewInputProtocol?
    var interactor: HomeInteractorInputProtocol
    var router: HomeRouterProtocol
    private var pEndpoint: Endpoint = .trending
    
    init(view: HomeViewInputProtocol,
         interactor: HomeInteractorInputProtocol,
         router: HomeRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

// MARK: - Extensions

// MARK: - V I E W · T O · P R E S E N T E R
extension HomePresenter: HomeViewOutputProtocol {
    func getDataMovies(endPoint: Endpoint) {
        self.router.showAnimation {
            self.pEndpoint = endPoint
            self.interactor.getDataMovies(endPoint: self.pEndpoint) {
                self.router.hideAnimation {}
            }
        }
    }
    
    func getMovieImage(imagePath: String, completion: @escaping (UIImage?) -> Void) {
        interactor.getMovieImage(imagePath: imagePath, completion: completion)
    }
    
    func saveFavorite(index: Int) {
        interactor.saveFavorite(index: index) {
            self.getDataMovies(endPoint: self.pEndpoint)
        }
    }
    
    func deleteFavorite(index: Int) {
        interactor.deleteFavorite(index: index) {
            self.getDataMovies(endPoint: self.pEndpoint)
        }
    }
    
    func showSearchModule() {
        router.showSearchModule()
    }
    
    func showDetailModule(movie: ListMovieProtocol) {
        router.showDetailModule(movie: movie)
    }
}

// MARK: - I N T E R A C T O R · T O · P R E S E N T E R
extension HomePresenter: HomeInteractorOutputProtocol {
    func presentDataMovies(movies: [ListMovieProtocol]?) {
        view?.showViewDataMovies(movies: movies)
    }
}
