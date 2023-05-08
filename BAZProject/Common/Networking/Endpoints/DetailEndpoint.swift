//
//  DetailEndpoint.swift
//  BAZProject
//
//  Created by gescarcega on 05/05/23.
//

import Foundation

enum DetailEndpoint: EndpointProtocol {
    
    case movie(Int), tv(Int), person(Int)
    
    var path: String {
        switch self {
        case .movie(let id): return "/3/movie/\(id)"
        case .tv(let id): return "/3/tv/\(id)"
        case .person(let id): return "/3/person/\(id)"
        }
    }
    
    var queries: [URLQueryItem]? {
        switch self {
        case .movie, .tv: return [URLQueryItem(name: "append_to_response", value: "recommendations,reviews,similar,credits")]
        case .person: return [URLQueryItem(name: "append_to_response", value: "combined_credits")]
        }
    }
    
}
