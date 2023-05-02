//
//  Movie.swift
//  BAZProject
//
//

import Foundation

struct Movie: MovieInfo, Codable {
    let id: Int
    let title: String
    let posterPath: String
    let overview: String
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
        case overview = "overview"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.posterPath = try values.decode(String.self, forKey: .posterPath)
        self.overview = try values.decode(String.self, forKey: .overview)
        self.backdropPath = try? values.decode(String?.self, forKey: .backdropPath)
    }
    
    func encode(to encoder: Encoder) throws {}
}
