//
//  MoviesPresenter.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//

import Foundation

class MoviesPresenter {
    
    weak var view       : MoviesViewInputProtocol?
    var interactor      : MoviesInteractorInputProtocol
    var router          : MoviesRouterProtocol
    
    init(view: MoviesViewInputProtocol,
         interactor: MoviesInteractorInputProtocol,
         router: MoviesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}
// MARK: Extension
extension MoviesPresenter: MoviesViewOutputProtocol{
    
    func searchMoview(with word: String) {
        interactor.consultServiceSearch(with: word)
    }
    
}
extension MoviesPresenter: MoviesInteractorOutputProtocol{
    
    func setResponseMovies(with moviesData: [MovieData]) {
        view?.showResultMovies(with: moviesData)
    }
    
    func setError() {
        if let view = view{
            router.presentAlert(CWAlert.simpleWith(message: "No se encontraron resultados"), from: view)
        }
    }
    
}
