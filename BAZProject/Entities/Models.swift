//
//  Models.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation



///Model that stores the response from TheMobieDB
class MovieApiResult: Decodable {
    var results: [Movie]?
}

///Model that stores a movie information, such as id, original title, overview, poster path and release date
class Movie: Decodable,Viewable {
    var id: Int
    var originalTitle: String
    var overview: String
    var posterPath: String?
    var releaseDate: String
    
    ///Enumeration to get rid of underscores
    enum CodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    ///Initializer to create an instance from Decoder
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
    }
    
    func getTitle() -> String {
        return originalTitle
    }
    
    func getImagePath() -> String {
        guard let path = posterPath else { return "" }
        return path
    }
    
    func getReleaseData() -> String {
        return releaseDate
    }
}
