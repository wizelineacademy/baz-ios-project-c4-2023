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
}

final class MovieInteractorMock: MovieInteractorInputProtocol, MovieRemoteDataManagerOutputProtocol {
    
    var presenter: MovieInteractorOutputProtocol?
    var remoteDatamanager: MovieRemoteDataManagerInputProtocol?
    var calls: [MovieMainInteractorMockCalls] = []
    
    func fetchMovies() {
        calls.append(.fetchMovies)
    }

    func moviesFetched(_ movies: [Movie]) {
        calls.append(.moviesFetched)
    }
    
}

