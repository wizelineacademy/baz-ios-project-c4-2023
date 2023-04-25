//
//  Models.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation


// TODO: (SDA) Erase this class
///Model that stores the response from TheMobieDB
class MovieApiResult: Decodable {
    var results: [Movie]?
}

// TODO: (SDA) Se how changes the implementation
///Model that stores a movie information, such as id, original title, overview, poster path and release date
struct Movie {
    var id: Int
    var originalTitle: String
    var overview: String
    var posterPath: String?
    var releaseDate: String

    ///Initializer to create an instance from Decoder
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
//        originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle) ?? ""
//        overview = try container.decodeIfPresent(String.self, forKey: .overview) ?? ""
//        posterPath = try container.decodeIfPresent(String.self, forKey: .posterPath)
//        releaseDate = try container.decodeIfPresent(String.self, forKey: .releaseDate) ?? ""
//    }
}

extension Movie: Decodable {
    ///Enumeration to get rid of underscores
    enum MovieCodingKeys: String, CodingKey {
        case id
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    init(from decoder: Decoder) throws {
        let movieContainer = try decoder.container(keyedBy: MovieCodingKeys.self)
        
        id = try movieContainer.decode(Int.self, forKey: .id)
        originalTitle = try movieContainer.decode(String.self, forKey: .originalTitle)
        overview =  try movieContainer.decode(String.self, forKey: .overview)
        posterPath = try movieContainer.decode(String.self, forKey: .posterPath)
        releaseDate = try movieContainer.decode(String.self, forKey: .releaseDate)
    }
}

extension Movie: Viewable {
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
