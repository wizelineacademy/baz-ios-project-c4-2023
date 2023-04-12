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
    func searchMovies(with query: String?) {
        if let query = query {
            self.interactor?.fetchSearchResults(with: query)
        }
    }
}

extension SearchPresenter: SearchInteractorOutputProtocol {
    func searchResultsFecthed(searchResults: [SearchResult]) {
        self.searchResults = searchResults
        self.view?.reloadData()
    }
}

