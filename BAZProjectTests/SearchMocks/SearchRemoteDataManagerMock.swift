//
//  SearchRemoteDataManagerMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 04/05/23.
//

import Foundation

import Foundation

@testable import BAZProject

enum RemoteDataManagerMock{
    case fetchSearchResults
}

class SearchRemoteDataManagerMock: SearchRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    var calls:[RemoteDataManagerMock] = []
    
    func fetchSearchResults(with query: String) {
        calls.append(.fetchSearchResults)
    }
}
