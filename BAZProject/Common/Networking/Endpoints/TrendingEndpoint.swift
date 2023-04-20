//
//  TrendingEndpoint.swift
//  BAZProject
//
//  Created by gescarcega on 04/04/23.
//

import Foundation

struct TrendingEndpoint: EndpointProtocol {
    var queries: [URLQueryItem]? = nil
    var path: String { return "/3/trending/movie/day" }
}
