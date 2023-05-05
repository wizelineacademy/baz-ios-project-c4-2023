//
//  MovieFound.swift
//  BAZProject
//
//  Created by Carlos Garcia on 21/04/23.
//

import Foundation

struct MovieFound: MovieFoundInfo, Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let overview: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "name"
        case posterPath = "poster_path"
        case overview = "overview"
        case backdropPath = "backdrop_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.posterPath = try? values.decode(String.self, forKey: .posterPath)
        self.overview = try? values.decode(String.self, forKey: .overview)
        self.backdropPath = try? values.decode(String?.self, forKey: .backdropPath)
    }
    
    func encode(to encoder: Encoder) throws {}
    
    init(id: Int, title: String) {
        self.id = id
        self.title = title
        self.posterPath = nil
        self.overview = nil
        self.backdropPath = nil
    }
}
