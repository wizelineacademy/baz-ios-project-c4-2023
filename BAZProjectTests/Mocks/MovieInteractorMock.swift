//
//  MovieInteractorMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 20/04/23.
//

import Foundation

@testable import BAZProject

enum MovieMainInteractorMockCalls {
    case fetchMovies
    case moviesFetched
    case handleService
}

final class MovieInteractorMock: MovieInteractorInputProtocol, MovieRemoteDataManagerOutputProtocol {

    var presenter: MovieInteractorOutputProtocol?
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol?
    var catchedError: ServiceError?
    var calls: [MovieMainInteractorMockCalls] = []
    
    func fetchMovies() {
        calls.append(.fetchMovies)
    }

    func moviesFetched(_ movies: [Movie]) {
        calls.append(.moviesFetched)
    }
    
    func handleService(error: Error) {
        self.catchedError = (error as? ServiceError)
        calls.append(.handleService)
    }
    
    
}

