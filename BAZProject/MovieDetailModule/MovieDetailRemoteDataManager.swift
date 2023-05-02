//
//  MovieDetailRemoteDataManager.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 27/04/23.
//  
//

import Foundation

class MovieDetailRemoteDataManager: MovieDetailRemoteDataManagerInputProtocol {
    
    private var service: ServiceProtocol
    var remoteRequestHandler: MovieDetailRemoteDataManagerOutputProtocol?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchMovieDetail(of movieId: Int) {
        guard let movieDetailURL = MovieRequest.getMovieDetail(of: movieId) else { return }
        service.get(movieDetailURL) { [weak self] (result: Result<MovieDetail, Error>) in
            switch result {
            case .success(let movieDetail):
                self?.remoteRequestHandler?.movieDetailFetched(with: movieDetail)
                break
            case .failure(_):
                //TODO: Implement error handler
                print("error")
                break
            }
        }
    }
}
