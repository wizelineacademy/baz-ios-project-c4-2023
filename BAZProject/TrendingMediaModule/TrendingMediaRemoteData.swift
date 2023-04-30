//
//  TrendingMediaRemoteData.swift
//  BAZProject
//
//

import Foundation

class TrendingMediaRemoteData {
    
    private let requestHandler = RequestHandler(withSession: URLSession.shared)

    func getMediaItems() async throws -> [MediaDataObject]? {
        let data = try await requestHandler.get(TrendingEndpoint())
        return try GenericResponseDataObject(data: data)?.results
    }
    
}
