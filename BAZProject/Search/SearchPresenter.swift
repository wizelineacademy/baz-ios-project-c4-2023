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

    func getMovieSearch(endPoint: Endpoint) {
        interactor.getMovieSearch(endPoint: endPoint)
    }
    
    func getMovieImage(index: Int, completion: @escaping (UIImage?) -> Void) {
        interactor.getMovieImage(index: index, completion: completion)
    }
}

// MARK: - I N T E R A C T O R · T O · P R E S E N T E R
extension SearchPresenter: SearchInteractorOutputProtocol {
    func presentDataMovies(movies: [ListMovieProtocol]?) {
        view?.showViewDataMovies(movies: movies)
    }
    

}
