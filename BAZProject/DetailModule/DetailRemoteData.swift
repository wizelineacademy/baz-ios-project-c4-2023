//
//  DetailRemoteData.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

class DetailRemoteData {
    
    init(sessionHandler: RequestHandlerProtocol = RequestHandler(withSession: URLSession.shared)) {
        
    }
    
    func getMovieDetails(id: Int) async throws -> [MovieDetailDataObject] {
        
        return []
    }
    
}
