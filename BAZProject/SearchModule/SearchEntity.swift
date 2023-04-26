//
//  SearchEntity.swift
//  BAZProject
//
//  Created by Ricardo Omar Martinez Nava on 10/04/23.
//

import Foundation

struct SearchResult: Codable {
    let id: Int?
    let title: String?
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
    }
}
