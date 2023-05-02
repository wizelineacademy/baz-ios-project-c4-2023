//
//  MovieDetailInteractor.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 27/04/23.
//  
//

import Foundation

class MovieDetailInteractor {
    var presenter: MovieDetailInteractorOutputProtocol?
    
    var remoteDatamanager: MovieDetailRemoteDataManagerInputProtocol?
}

extension MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    func fetchMovieDetail(of movieId: Int?) {
        if let movieId = movieId {
            self.remoteDatamanager?.fetchMovieDetail(of: movieId)
        }
    }
}

extension MovieDetailInteractor: MovieDetailRemoteDataManagerOutputProtocol {
    func movieDetailFetched(with movieDetail: MovieDetail) {
        self.presenter?.movieDetailFetched(with: movieDetail)
    }
}
