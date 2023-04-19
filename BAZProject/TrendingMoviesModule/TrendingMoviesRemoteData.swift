//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class TrendingMoviesRemoteData {

    private let requestHandler = RequestHandler(withSession: URLSession.shared)

    func getMovies() async throws -> [Movie]? {
        let data = try await requestHandler.get(TrendingEndpoint())
        return try TrendingAPIModel(data: data)?.results
    }
    
    func searchMovies(_ searchText: String) async throws -> [Movie]? {
        let endpoint = SearchEndpoint(searchText)
        let data = try await requestHandler.get(endpoint)
        return try TrendingAPIModel(data: data)?.results
    }

}
