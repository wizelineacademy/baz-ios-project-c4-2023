//
//  TrendingMediaRemoteData.swift
//  BAZProject
//
//

import Foundation

class TrendingMediaRemoteData {
    
    private var requestHandler: RequestHandlerProtocol
    
    init(requestHandler: RequestHandlerProtocol = RequestHandler(withSession: URLSession.shared)) {
        self.requestHandler = requestHandler
    }

    func getMediaItems(section: TrendingMediaSection) async throws -> [MediaDataObject]? {
        let data = try await requestHandler.get(TrendingEndpoint(section: section))
        return try GenericResponseDataObject(data: data)?.results
    }
    
}
