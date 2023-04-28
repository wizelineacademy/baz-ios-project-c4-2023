//
//  Movie.swift
//  BAZProject
//
//

import Foundation

// Movie implements the protocol for use properties and add some more optionals
struct Movie: Decodable, MovieProtocol {

    var id: Int?
    var title: String?
    var poster_path: String?
    var adult: Bool?
    var backdrop_path: String?
    var genre_ids: [Int]?
    var media_type: String?
    var original_language: String?
    var original_title: String?
    var overview: String?
    var popularity: Double?
    var release_date: String?
    var video: Bool?
    var vote_average: Double?
    var vote_count: Int?
    
}
