//
//  TrendingInteractorMock.swift
//  BAZProjectTests
//
//  Created by Ben Frank V. on 25/04/23.
//

import Foundation

class TrendingInteractorMock: TrendingInteractorInputProtocol {
    var presenter: TrendingInteractorOutputProtocol?
    
    var remoteDatamanager: TrendingRemoteDataManagerInputProtocol?
    
    var entity: TrendingEntity?
    
    func getNavTitle() -> String? {
        return ""
    }
    
    func fetchMovies() {
    }
    
    
}

extension TrendingInteractorMock: TrendingRemoteDataManagerOutputProtocol {
    func handleGetMovies(_ result: [Movie]) {
        presenter?.onReceivedMovies(result)
    }
    
    func handleGetErrorServiceMovies(_ error: Error) {
        presenter?.showMoviesError(error)
    }
}
