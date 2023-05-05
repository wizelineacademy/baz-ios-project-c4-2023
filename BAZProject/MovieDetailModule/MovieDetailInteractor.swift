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
    var data: MovieDetail?
    let saveData: MovieFavorites = MovieFavorites()
}

extension MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    
    func saveFavoriteMovie(of movieId: Int?) {
        guard let idMovie = movieId else { return }
        saveData.favorite(idMovie)
    }
    
    func deleteToFavoriteMovie(of movieId: Int?) {
        guard let idMovie = movieId else { return}
        saveData.delete(idMovie)
    }
    
    
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
