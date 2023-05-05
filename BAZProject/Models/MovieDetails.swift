//
//  MovieDetails.swift
//  BAZProject
//
//  Created by Carlos Garcia on 28/04/23.
//

import Foundation

struct MovieDetails: MovieDetailsInfo, Codable {
    let id: Int
    let title: String
    let posterPath: String?
    
    let overview: String?
    let backdropPath: String?
    
    var releaseDate: String
    var runtime: Int
    var voteAverage: Double
    var voteCount: Int
    
    var credits: MovieCreditsInfo?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case posterPath = "poster_path"
        case overview = "overview"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case runtime = "runtime"
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try values.decode(Int.self, forKey: .id)
        self.title = try values.decode(String.self, forKey: .title)
        self.posterPath = try? values.decode(String.self, forKey: .posterPath)
        self.overview = try? values.decode(String.self, forKey: .overview)
        self.backdropPath = try? values.decode(String?.self, forKey: .backdropPath)
        self.releaseDate = try values.decode(String.self, forKey: .releaseDate)
        self.runtime = try values.decode(Int.self, forKey: .runtime)
        self.voteAverage = try values.decode(Double.self, forKey: .voteAverage)
        self.voteCount = try values.decode(Int.self, forKey: .voteCount)
    }
    
    func encode(to encoder: Encoder) throws {}
}
