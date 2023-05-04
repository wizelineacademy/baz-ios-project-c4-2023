//
//  SearchEndpoint.swift
//  BAZProject
//
//  Created by gescarcega on 18/04/23.
//

import Foundation

enum SearchEndpoint: EndpointProtocol {
    
    case movies(String)
    case series(String)
    case people(String)
    case keyword(String)
    
    var queries: [URLQueryItem]? {
        switch self {
        case .movies(let searchText): return [URLQueryItem(name: "query", value: searchText)]
        case .series(let searchText): return [URLQueryItem(name: "query", value: searchText)]
        case .people(let searchText): return [URLQueryItem(name: "query", value: searchText)]
        case .keyword(let searchText): return [URLQueryItem(name: "query", value: searchText)]
        }
    }
    var path: String {
        switch self {
        case .movies: return "/3/search/movie"
        case .series: return "/3/search/tv"
        case .people: return "/3/search/person"
        case .keyword: return "/3/search/multi"
        }
    }

}
