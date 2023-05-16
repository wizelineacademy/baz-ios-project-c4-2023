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
    case handleService
}

class SearchInteractorMock: SearchInteractorInputProtocol, SearchRemoteDataManagerOutputProtocol {
    
    var presenter: SearchInteractorOutputProtocol?
    var remoteDatamanager: SearchRemoteDataManagerInputProtocol?
    var callsSearch: [SearchInteractorMockCalls] = []
    
    func fetchSearchResults(with query: String) {
        callsSearch.append(.fetchSearchResults)
    }
    
    func searchResultsFecthed(searchResults: [SearchResult]) {
        callsSearch.append(.searchResultsFecthed)
    }
    
    func handleService(error: Error) {
        callsSearch.append(.handleService)
    }
    
}
