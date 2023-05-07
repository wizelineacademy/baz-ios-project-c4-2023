//
//  SearchRemoteData.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import Foundation

class SearchRemoteData {
    
    private var requestHandler: RequestHandlerProtocol
    
    init(requestHandler: RequestHandlerProtocol = RequestHandler(withSession: URLSession.shared)) {
        self.requestHandler = requestHandler
    }
    
    func searchMedia(_ searchText: String) async throws -> [MediaDataObject]? {
        let endpoint = SearchEndpoint.keyword(searchText)
        let data = try await requestHandler.get(endpoint)
        return try GenericResponseDataObject(data: data)?.results
    }
    
    func searchMovies(_ searchText: String) async throws -> [MediaDataObject]? {
        let endpoint = SearchEndpoint.movies(searchText)
        let data = try await requestHandler.get(endpoint)
        return try GenericResponseDataObject(data: data)?.results
    }
    
    func searchSeries(_ searchText: String) async throws -> [MediaDataObject]? {
        let endpoint = SearchEndpoint.series(searchText)
        let data = try await requestHandler.get(endpoint)
        return try GenericResponseDataObject(data: data)?.results
    }
    
    func searchPeople(_ searchText: String) async throws -> [MediaDataObject]? {
        let endpoint = SearchEndpoint.people(searchText)
        let data = try await requestHandler.get(endpoint)
        return try GenericResponseDataObject(data: data)?.results
    }
}
