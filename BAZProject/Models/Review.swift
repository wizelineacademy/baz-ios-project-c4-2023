//
//  Review.swift
//  BAZProject
//
//  Created by jmgarciaca on 04/05/23.
//

import Foundation

/// MovieList is a Decodable struct that represents a list of reviews.
/// It contains an array of Review objects.
struct ReviewList: Codable {
    let results: [Review]
}

/// A struct that represents a review.
/// It contains the following properties:
/// - id: An optional integer that represents the unique ID of the review.
/// - author: An optional string that represents the name of the author of the review.
/// - author_details:
/// - content: An optional string that represents the content of the review.
/// - created_at: An optional string that represents the creation date of the review.
/// - updated_at An optional string that represents the date the review was last updated.
struct Review: Codable {
    let id: String
    let author: String?
    let author_details: AuthorDetails
    let content: String?
    let created_at: String?
    let updated_at: String?
}

/// A struct that represents the details of a review's author.
/// It contains the following properties:
/// - name: An optional string that represents the name of the author.
/// - username: An optional string that represents the username of the author.
/// - avatar_path: An optional string that represents the path to the author's avatar image.
/// - rating: An optional string that represents the rating of the author.
struct AuthorDetails: Codable {
    let name: String?
    let username: String?
    let avatar_path: String?
    let rating: Int?
}
