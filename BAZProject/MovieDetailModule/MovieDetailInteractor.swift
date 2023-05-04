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
    let saveData: SaveMovies = SaveMovies()
}

extension MovieDetailInteractor: MovieDetailInteractorInputProtocol {
    
    
    func deleteToFavoriteMovie() {
        guard let idMovie = data?.id else { return }
        saveData.delete(title: .favoriteMovies, idMovie: idMovie)
    }
    
    func saveFavoriteMovie() {
        do {
            guard let idMovie = data?.id else { return }
            if !saveData.isSave(title: .favoriteMovies, idMovie: idMovie) {
                try saveData.save(idMovie, title: .favoriteMovies)
            }
        } catch {
            debugPrint("Error")
        }
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
