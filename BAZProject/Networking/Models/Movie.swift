//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: Decodable {
    
    var id: Int?
    var title: String?
    var posterURL: String?
    
    private enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterURL = "poster_path"
    }
}
