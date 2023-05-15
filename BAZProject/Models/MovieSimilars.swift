//
//  MovieSimilars.swift
//  BAZProject
//
//  Created by nmorenoa on 02/05/23.
//

import Foundation

struct MovieSimilars: Decodable {
    
    var totalResults    : Int?
    var page            : Int?
    var totalPages      : Int?
    var similars        : [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case totalResults   = "total_results"
        case page
        case totalPages     = "total_pages"
        case similars       = "results"
    }
    
}
