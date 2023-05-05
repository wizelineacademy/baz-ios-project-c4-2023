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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.posterPath = try? values.decode(String.self, forKey: .posterPath)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        if let posterPath = self.posterPath {
            try container.encode(posterPath, forKey: .posterPath)
        }
    }
    
    init(id: Int, title: String, posterPath: String? = nil) {
        self.id = id
        self.title = title
        self.posterPath = posterPath
    }
}
