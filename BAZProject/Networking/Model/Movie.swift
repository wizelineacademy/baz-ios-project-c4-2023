//
//  Movie.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 24/04/23.
//

import Foundation

struct MovieApiResponse: Decodable {
    let page: Int
    let numberOfResults: Int
    let numberOfPages: Int
    let movies: [Movie]
    
    private enum MovieApiResponseCodingKeys: String, CodingKey {
        case page
        case numberOfResults = "total_results"
        case numberOfPages = "total_pages"
        case movies = "results"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieApiResponseCodingKeys.self)
        
        page = try container.decode(Int.self, forKey: .page)
        numberOfResults = try container.decode(Int.self, forKey: .numberOfResults)
        numberOfPages = try container.decode(Int.self, forKey: .numberOfPages)
        movies =  try container.decode([Movie].self, forKey: .movies)
    }
}

//extension MovieApiResponse: Decodable {
//    
//    
//}
