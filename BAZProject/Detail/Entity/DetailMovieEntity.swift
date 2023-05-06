//
//  DetailMovieEntity.swift
//  BAZProject
//
//  Created by Ben Frank V. on 03/05/23.
//  
//

import Foundation

struct DetailMovieEntity {
    
    var baseInfo: Movie?
    var reviews: [MovieReviews] = []
    var credits: MovieCreditsResult?
    var casting: [MovieCast] = []
    var processedCast: String = ""
    var genere: String = ""
    var recomendations: [Movie] = []
    var similarMovies: [Movie] = []

}

struct MovieReviewsResult: Decodable{
    var results:  [MovieReviews]
}

struct MovieReviews: Decodable, Equatable{
    var author: String
    var author_details: AuthorReviewsDetails
    var content: String?
    var created_at: String
    var id: String
    var updated_at: String?
    var url: String?
}

struct AuthorReviewsDetails: Decodable, Equatable{
    var name: String?
    var username: String?
    var avatar_path: String?
    var rating: String?
}

struct MovieCreditsResult: Decodable{
    var id: Int
    var cast: [MovieCast]
    var crew: [MovieCrew]
}

struct MovieCast: Decodable, Equatable{
    var adult: Bool
    var gender: Int?
    var id: Int
    var known_for_department: String
    var name: String
    var original_name: String
    var popularity: Double
    var profile_path: String?
    var cast_id: Int
    var character: String
    var credit_id: String
    var order: Int
    
}

struct MovieCrew: Decodable, Equatable{
    var adult: Bool
    var gender: Int?
    var id: Int
    var known_for_department: String
    var name: String
    var original_name: String
    var popularity: Double
    var profile_path: String?
    var credit_id: String
    var department: String
    var job: String
    
}

struct MovieRecommendationsResult: Decodable{
    var results:  [Movie]
}

struct SimilarMoviesResult: Decodable{
    var results:  [Movie]
}
