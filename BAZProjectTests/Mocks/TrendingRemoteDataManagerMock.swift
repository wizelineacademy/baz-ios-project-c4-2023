//
//  TrendingRemoteDataManagerMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 20/04/23.
//

import Foundation
@testable import BAZProject

enum TrendingRemoteDataManagerCalls{
    case fetchMovies
}

class PokedexMainRemoteDataManagerMock: MovieRemoteDataManagerInputProtocol {
    var remoteRequestHandler: BAZProject.MovieRemoteDataManagerOutputProtocol?
    
    var calls:[TrendingRemoteDataManagerCalls] = []
    
    func fetchMovies() {
        calls.append(.fetchMovies)
    }
}
