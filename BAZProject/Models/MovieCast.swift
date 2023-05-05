//
//  MovieCast.swift
//  BAZProject
//
//  Created by Carlos Garcia on 28/04/23.
//

import Foundation

struct MovieCast: MovieCastInfo, Codable {
    var id: Int
    var name: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.name = try values.decode(String.self, forKey: .name)
    }
    
    func encode(to encoder: Encoder) throws {}
}
