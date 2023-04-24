//
//  TrendingRemoteDataManager.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 08/04/23.
//  
//

import Foundation

class TrendingRemoteDataManager: TrendingRemoteDataManagerInputProtocol {
    
    private let service: ServiceProtocol
    private let trendingURL = MovieRequest.getURL(endpoint: .trendingMovies)
    weak var remoteRequestHandler: TrendingRemoteDataManagerOutputProtocol?

    init(service: ServiceProtocol) {
        self.service = service
    }
    
    /// Obtener resultado del API depende URL
    func fetchMovies() {
        guard let trendingURL = trendingURL else { return }
        service.get(trendingURL) { [weak self] (result: Result<Response<[Movie]>, Error>) in
            switch result {
            case .success(let response):
                self?.remoteRequestHandler?.moviesFetched(response.results ?? [])
                break
            case .failure(let error):
                self?.remoteRequestHandler?.handleService(error: error)
                break
            }
        }
    }
}

