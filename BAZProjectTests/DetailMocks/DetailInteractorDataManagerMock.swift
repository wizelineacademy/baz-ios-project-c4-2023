//
//  DetailInteractorDataManagerMock.swift
//  BAZProjectTests
//
//  Created by Ricardo Omar Martinez Nava on 08/05/23.
//

import Foundation

@testable import BAZProject

enum MovieDetailDataManagerMock{
    case fetchSearchResults
}

class DetailInteractorDataManagerMock: MovieDetailRemoteDataManagerInputProtocol {
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol?
    var detailcalls:[MovieDetailDataManagerMock] = []
    
    func fetchMovieDetail(of movieId: Int) {
        detailcalls.append(.fetchSearchResults)
    }
}
