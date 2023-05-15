//
//  MovieReview.swift
//  BAZProject
//
//  Created by ksolano on 08/05/23.
//

import Foundation

/// model that movie revies that contains an array
struct MovieReviewResults: Decodable {
    var results: [MovieReview]?
}

/// Model that has the Review of a movie
struct MovieReview: Decodable {
    var author: String?
    var author_details: AuthorDetails?
    var content: String?
    var created_at: String?
    var updated_at: String?
    var url: String?
}

/// Model that has the author movie information
struct AuthorDetails: Decodable {
    var name: String?
    var username: String?
    var avatar_path: String?
    var rating: Double?
}
