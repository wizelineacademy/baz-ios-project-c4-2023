//
//  UpcomingRemoteDataManager.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class UpcomingRemoteDataManager: UpcomingRemoteDataManagerInputProtocol {
    
    private let service: ServiceProtocol
    private let UpcomingURL = MovieRequest.getURL(endpoint: .upcomingMovies)
    weak var remoteRequestHandler: UpcomingRemoteDataManagerOutputProtocol?

    init(service: ServiceProtocol) {
        self.service = service
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
