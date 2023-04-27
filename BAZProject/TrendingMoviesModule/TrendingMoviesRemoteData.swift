//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class TrendingMoviesRemoteData {
    
    private let requestHandler = RequestHandler(withSession: URLSession.shared)

    func getMovies() async throws -> [MediaDataObject]? {
        let data = try await requestHandler.get(TrendingEndpoint())
        return try GenericResponseDataObject(data: data)?.results
    }
    
    func searchMovies(_ searchText: String) async throws -> [MediaDataObject]? {
        let endpoint = SearchEndpoint(searchText)
        let data = try await requestHandler.get(endpoint)
        return try GenericResponseDataObject(data: data)?.results
    }
    
}
