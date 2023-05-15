//
//  MovieRecomendations.swift
//  BAZProject
//
//  Created by nmorenoa on 29/04/23.
//

import Foundation

struct RecomendationsResult: Decodable {
    
    var totalResults    : Int?
    var page            : Int?
    var totalPages      : Int?
    var recomendations          : [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case totalResults   = "total_results"
        case page
        case totalPages     = "total_pages"
        case recomendations = "results"
    }
    
}
