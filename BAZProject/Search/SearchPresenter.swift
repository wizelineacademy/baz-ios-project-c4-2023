//  SearchPresenter.swift
//  BAZProject
//
//  Created by jehernandezg on 20/04/23.

import UIKit

// MARK: - Class
class SearchPresenter {
    // MARK: - Properties
    weak var view: SearchViewInputProtocol?
    var interactor: SearchInteractorInputProtocol
    var router: SearchRouterProtocol
    private var pEndpoint: Endpoint = .trending
    
    init(view: SearchViewInputProtocol,
         interactor: SearchInteractorInputProtocol,
         router: SearchRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}

// MARK: - Extensions

// MARK: - V I E W · T O · P R E S E N T E R
extension SearchPresenter: SearchViewOutputProtocol {
    // MARK: - Functions
    func getMovieSearch(endPoint: Endpoint) {
        self.router.showAnimation {
            self.pEndpoint = endPoint
            self.interactor.getMovieSearch(endPoint: self.pEndpoint) {
                self.router.hideAnimation {}
            }
        }
    }
    
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        interactor.getMovieImage(index: index, completion: completion)
    }
    
    func saveFavorite(index: Int) {
        interactor.saveFavorite(index: index) {
            self.getMovieSearch(endPoint: self.pEndpoint)
        }
    }
    
    func deleteFavorite(index: Int) {
        interactor.deleteFavorite(index: index) {
            self.getMovieSearch(endPoint: self.pEndpoint)
        }
    }
    
    func showDetailModule(movie: ListMovieProtocol) {
        router.showDetail(movie: movie)
    }
}

// MARK: - I N T E R A C T O R · T O · P R E S E N T E R
extension SearchPresenter: SearchInteractorOutputProtocol {
    // MARK: - Functions
    func presentDataMovies(movies: [ListMovieProtocol]?) {
        view?.showViewDataMovies(movies: movies)
    }
    
}
