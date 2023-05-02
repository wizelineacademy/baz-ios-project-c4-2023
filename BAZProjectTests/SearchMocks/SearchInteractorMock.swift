//
//  SearchInteractorMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 26/04/23.
//

import Foundation

import Foundation

@testable import BAZProject

enum SearchInteractorMockCalls {
    case fetchSearchResults
    case searchResultsFecthed
}

class SearchInteractorMock: SearchInteractorInputProtocol, SearchRemoteDataManagerOutputProtocol {
    
    var presenter: SearchInteractorOutputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    var calls: [SearchInteractorMockCalls] = []
    
    func fetchSearchResults(with query: String) {
        calls.append(.fetchSearchResults)
    }
    
    func searchResultsFecthed(searchResults: [BAZProject.SearchResult]) {
        calls.append(.searchResultsFecthed)
    }
    
    
    
    
    
}
