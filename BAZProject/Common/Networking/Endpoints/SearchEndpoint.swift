//
//  SearchEndpoint.swift
//  BAZProject
//
//  Created by gescarcega on 18/04/23.
//

import Foundation

struct SearchEndpoint: EndpointProtocol {
    
    var queries: [URLQueryItem]?
    
    var path = "/3/search/movie"
    
    init(_ searchText: String) {
        queries = [URLQueryItem(name: "query", value: searchText)]
    }
}
