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
    var recomendations          : [Recomendations]?
    
    enum CodingKeys: String, CodingKey {
        case totalResults   = "total_results"
        case page
        case totalPages     = "total_pages"
        case recomendations = "results"
    }
    
}

struct Recomendations: Decodable{
    
    var title           : String?
    var posterPath      : String?
    var overview        : String?
    
    enum CodingKeys: String, CodingKey {
        case title
        case posterPath     = "poster_path"
        case overview
    }
    
}
