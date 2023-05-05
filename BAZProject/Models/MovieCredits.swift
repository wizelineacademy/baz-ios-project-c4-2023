//
//  MovieCredits.swift
//  BAZProject
//
//  Created by Carlos Garcia on 28/04/23.
//

import Foundation

struct MovieCredits: MovieCreditsInfo, Codable {
    var id: Int
    var cast: [MovieCastInfo]
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case cast = "cast"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.cast = try values.decode([MovieCast].self, forKey: .cast)
    }
    
    func encode(to encoder: Encoder) throws {}
}
