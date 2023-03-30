//
//  MovieEndpoint.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

enum MovieEndpoint: EndpointProtocol {
    
    static private let mainURL: String = "https://api.themoviedb.org/3/"
    static private let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    
    case trending
    
    private var builtURL: URL? {
        switch self {
        case .trending: return URL(string: "\(MovieEndpoint.mainURL)trending/movie/day?api_key=\(MovieEndpoint.apiKey)")
        }
    }
    
    var request: URLRequest? {
        guard let builtURL = builtURL else { return nil }
        switch self {
        case .trending: return URLRequest(url: builtURL)
        }
    }
    
}
