//
//  DetailRemoteData.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

class DetailRemoteData {
    
    var sessionHandler: RequestHandlerProtocol
    
    init(sessionHandler: RequestHandlerProtocol = RequestHandler(withSession: URLSession.shared)) {
        self.sessionHandler = sessionHandler
    }
    
    func getMovieDetails(id: Int) async throws -> MovieDetailDataObject? {
        let data = try await sessionHandler.get(DetailEndpoint.movie(id))
        return try MovieDetailDataObject(data: data)
    }
    
}
