//
//  Models.swift
//  BAZProject
//
//  Created by Sergio Del Olmo Aguilar on 29/03/23.
//

import Foundation

class MovieApiResult: Decodable {
    var results: [Movie]?
}

class Movie: Decodable {
    var id: Int?
    var original_title: String?
    var overview: String?
    var poster_path: String?
    var release_date: String?
}
