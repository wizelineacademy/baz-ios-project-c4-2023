//
//  MovieAPI.swift
//  BAZProject
//
//

import Foundation

class TrendingAPIService {

    private let requestHandler = RequestHandler(withSession: URLSession.shared)

    func getMovies() async throws -> [Movie]? {
        let data = try await requestHandler.get(TrendingEndpoint())
        return try TrendingAPIModel(data: data)?.results
    }

}
