//
//  TrendingInteractorMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 20/04/23.
//

import Foundation

@testable import BAZProject

enum PokedexMainInteractorMockCalls {
    case fetchMovies
    case moviesFetched
    case handleerror
}

final class TrendingInteractorMock: TrendingInteractorInputProtocol, TrendingRemoteDataManagerOutputProtocol {
    
    var presenter: BAZProject.TrendingInteractorOutputProtocol?
    var remoteDatamanager: BAZProject.TrendingRemoteDataManagerInputProtocol?
    var remoteRequestHandler: BAZProject.TrendingRemoteDataManagerOutputProtocol?
    var catchedError: ServiceError?
    var calls: [PokedexMainInteractorMockCalls] = []
    
    func fetchMovies() {
        calls.append(.fetchMovies)
    }

    
    func moviesFetched(_ movies: [BAZProject.Movie]) {
        calls.append(.moviesFetched)
    }
    
    func handleService(error: Error) {
        calls.append(.handleerror)
    }
    
    
}
