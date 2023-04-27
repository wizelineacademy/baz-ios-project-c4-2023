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
    
}
