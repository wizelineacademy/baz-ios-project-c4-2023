//
//  SearchPresenter.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 10/04/23.
//  
//

import UIKit

class SearchPresenter {
    var view: SearchViewProtocol?
    var interactor: SearchInteractorInputProtocol?
    var router: SearchRouterProtocol?
    var searchResults: [SearchResult]?
}

extension SearchPresenter: SearchPresenterProtocol {
    
    /// Función para realizar busqueda
    /// - Parameter query: String search
    func searchMovies(with query: String?) {
        if let query = query {
            self.interactor?.fetchSearchResults(with: query)
        }
    }
    
    /// Función para entrar al detalle de Movie
    /// - Parameters:
    ///   - indexPath
    ///   - view
    func goToMovieDetail(of indexPath: IndexPath,from view: UIViewController) {
        if let movieID = self.searchResults?[indexPath.row].id {
            self.router?.goToMovieDetail(of: movieID, from: view)
        }
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    
    /// Función para obtener resultados de busqueda
    /// - Parameter searchResults: Obtener id, title, posterpath del entitie SearchResult
    func searchResultsFecthed(searchResults: [SearchResult]) {
        self.searchResults = searchResults
        self.view?.reloadData()
    }
}

