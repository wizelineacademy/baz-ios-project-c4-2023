//
//  MovieRemoteDataManager.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class MovieRemoteDataManager: MovieRemoteDataManagerInputProtocol {
    
    private let service: ServiceProtocol
    private let UpcomingURL: URL?
    weak var remoteRequestHandler: MovieRemoteDataManagerOutputProtocol?

    init(service: ServiceProtocol, endpoint: Endpoint) {
        self.service = service
        self.UpcomingURL = MovieRequest.getURL(endpoint: endpoint)
    }
    
    
    /// Obtener resultado del API depende URL
    func fetchMovies() {
        guard let UpcomingURL = UpcomingURL else { return }
        service.get(UpcomingURL) { [weak self] (result: Result<Response<[Movie]>, Error>) in
            switch result {
            case .success(let response):
                self?.remoteRequestHandler?.moviesFetched(response.results ?? [])
                break
            case .failure(_):
                break
            }
        }
    }
}
