//
//  DetailEndpoint.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

enum DetailEndpoint: EndpointProtocol {
    
    case movie(Int)
    
    var path: String {
        switch self {
        case .movie(let id): return"/3/movie/\(id)"
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .movie: return [URLQueryItem(name: "append_to_response", value: "recommendations,reviews,similar,credits")]
        }
    }
    
}
