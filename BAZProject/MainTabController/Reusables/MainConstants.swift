//
//  MainConstants.swift
//  BAZProject
//
//  Created by 989438 on 27/03/23.
//

import Foundation

enum MainConstants {
    // MARK: - Common
    private static let apiKey: String = "f6cd5c1a9e6c6b965fdcab0fa6ddd38a"
    static let mediaEndPoint: String = "https://image.tmdb.org/t/p/w500"
    static let trendingEndPoint: String = "trending/movie/day?api_key=\(MainConstants.apiKey)&language=es&region=MX&page=1"
}
