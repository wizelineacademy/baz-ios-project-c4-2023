//
//  RecentRemoteDataManager.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 11/04/23.
//  
//

import Foundation

class RecentRemoteDataManager: RecentRemoteDataManagerInputProtocol {
    
    private let service: ServiceProtocol
    private let RecentURL = MovieRequest.getURL(endpoint: .recentsMovies)
    weak var remoteRequestHandler: RecentRemoteDataManagerOutputProtocol?

    init(service: ServiceProtocol) {
        self.service = service
    }
    
    func fetchMovies() {
        guard let RecentURL = RecentURL else { return }
        service.get(RecentURL) { [weak self] (result: Result<Response<[Movie]>, Error>) in
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
