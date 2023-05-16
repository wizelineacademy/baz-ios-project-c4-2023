//
//  MovieRemoteDataManagerMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 26/04/23.
//

import Foundation

@testable import BAZProject

enum MovieRemoteDataManagerCalls{
    case fetchMovies
}

class MovieRemoteDataManagerMock: MovieRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: MovieRemoteDataManagerOutputProtocol?
    var calls:[MovieRemoteDataManagerCalls] = []
    
    func fetchMovies() {
        calls.append(.fetchMovies)
    }
}
