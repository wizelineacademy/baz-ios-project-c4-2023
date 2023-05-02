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
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
    }
    
    func encode(to encoder: Encoder) throws {}
}
