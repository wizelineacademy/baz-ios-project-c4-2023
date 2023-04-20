//
//  SearchMoviesPresenter.swift
//  BAZProject
//
//  Created by nmorenoa on 14/04/23.
//

import Foundation

class SearchMoviesPresenter {
    
    // MARK: Properties
    weak var view       : SearchMoviesViewInputProtocol?
    var interactor      : SearchMoviesInteractorInputProtocol
    var router          : SearchMoviesRouterProtocol
    var movies          : [MovieData] = []
    
    init(view: SearchMoviesViewInputProtocol,
         interactor: SearchMoviesInteractorInputProtocol,
         router: SearchMoviesRouterProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
}
// MARK: Extension
extension SearchMoviesPresenter: SearchMoviesViewOutputProtocol{
    
    func searchMoview(with word: String) {
        interactor.consultServiceSearch(with: word)
    }
    
}
extension SearchMoviesPresenter: SearchMoviesInteractorOutputProtocol{
    
    func setResponseMovies(with moviesData: [MovieData]) {
        self.movies.removeAll()
        self.movies = moviesData
        view?.showResultMovies()
    }
    
    func setError() {
        router.presentAlert(CWAlert.simpleWith(message: "No se encontraron resultados"))
    }
    
}
