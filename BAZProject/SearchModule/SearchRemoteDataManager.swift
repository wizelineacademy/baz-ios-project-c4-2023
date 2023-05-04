//
//  SearchRemoteDataManager.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 10/04/23.
//  
//

import Foundation

class SearchRemoteDataManager: SearchRemoteDataManagerInputProtocol {
    
    private var service: ServiceProtocol
    weak var remoteRequestHandler: SearchRemoteDataManagerOutputProtocol?
    
    init(service: ServiceProtocol) {
        self.service = service
    }
    
    /// Función para traer la busqueda 
    /// - Parameter query: String search
    func fetchSearchResults(with query: String) {
        guard let topRatedURL = MovieRequest.searchMovie(search: query) else { return }
        service.get(topRatedURL) { [weak self] (result: Result<Response<[SearchResult]>, Error>) in
            switch result {
            case .success(let response):
                self?.remoteRequestHandler?.searchResultsFecthed(searchResults: response.results ?? [])
                break
            case .failure(let error):
                self?.remoteRequestHandler?.handleService(error: error)
                break
            }
        }
    }
}
