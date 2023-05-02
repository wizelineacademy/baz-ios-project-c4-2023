//
//  MovieDetail.swift
//  BAZProject
//
//  Created by nmorenoa on 25/04/23.
//

import Foundation

struct MovieDetailResult: Decodable {
    
    var movies          : [MovieDetail]?
    var page            : Int?
    var totalPages      : Int?
    var totalResults    : Int?
    var id              : Int?
    
    enum CodingKeys: String, CodingKey {
        case movies         = "results"
        case page
        case totalPages     = "total_pages"
        case totalResults   = "total_results"
        case id
    }
    
}
struct MovieDetail: Decodable {
    
    var author          : String?
    var authorDetails   : AuthorDetails?
    var content         : String?
    var createdAt       : String?
    var id              : String?
    var updatedAt       : String?
    var url             : String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails  = "author_details"
        case content
        case createdAt      = "created_at"
        case id
        case updatedAt      = "updated_at"
        case url
    }
    
}

struct AuthorDetails: Decodable{
    
    var name        : String?
    var username    : String?
    var avatarPath  : String?
    var rating      : Double?
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath     = "avatar_path"
        case rating
    }
    
}
