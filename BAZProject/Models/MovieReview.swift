//
//  MovieReview.swift
//  BAZProject
//
//  Created by ksolano on 08/05/23.
//

import Foundation

struct MovieReviewResults: Decodable {
    
    var results: [MovieReview]?
}


struct MovieReview: Decodable {
    
    var author: String?
    var author_details: AuthorDetails?
    var content: String?
    var created_at: String?
    var updated_at: String?
    var url: String?
}

struct AuthorDetails: Decodable {
    
    var name: String?
    var username: String?
    var avatar_path: String?
    var rating: Double?
}
