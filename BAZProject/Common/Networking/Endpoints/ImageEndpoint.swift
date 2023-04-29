//
//  ImageEndpoint.swift
//  BAZProject
//
//  Created by gescarcega on 29/04/23.
//

import Foundation

struct ImageEndpoint: EndpointProtocol {
 
    var path: String = "/t/p/w500"
    var queries: [URLQueryItem]? = nil
    var key: String? = nil
    var host: String? = "image.tmdb.org"
    var cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
    
    init(path: String) {
        self.path.append(path)
    }
    
}
