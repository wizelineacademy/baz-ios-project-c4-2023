//
//  SearchInteractor.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 10/04/23.
//  
//

import Foundation

class SearchInteractor: SearchInteractorInputProtocol, SearchRemoteDataManagerOutputProtocol {
    var presenter: SearchInteractorOutputProtocol?
    
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    
    func fetchSearchResults(with query: String) {
        self.remoteDatamanager?.fetchSearchResults(with: query)
    }
    
    func searchResultsFecthed(searchResults: [SearchResult]) {
        self.presenter?.searchResultsFecthed(searchResults: searchResults)
    }
}
