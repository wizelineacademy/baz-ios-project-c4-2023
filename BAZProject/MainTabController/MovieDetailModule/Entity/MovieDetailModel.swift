//
//  MovieDetailModel.swift
//  BAZProject
//
//  Created by 989438 on 25/04/23.
//

import Foundation

enum MovieDetailModel: Comparable {
    private var comparisonValue: Int {
        switch self {
        case .summary:
            return 1
        case .starring:
            return 3
        case .similar:
            return 4
        case .recomended:
            return 5
        case .reviews:
            return 2
        }
    }
    static func < (lhs: MovieDetailModel, rhs: MovieDetailModel) -> Bool {
        return lhs.comparisonValue < rhs.comparisonValue
    }
    
    static func == (lhs: MovieDetailModel, rhs: MovieDetailModel) -> Bool {
        return lhs.comparisonValue == rhs.comparisonValue
    }
    
    case summary([Movie])
    case starring([ActorModel])
    case similar([Movie])
    case recomended([Movie])
    case reviews([ReviewModel])
    
    var items: [Any] {
        switch self {
        case .summary(let items),
                .similar(let items),
                .recomended(let items):
            return items
        case .starring(let items):
            return items
        case .reviews(let items):
            return items
        }
    }
    
    var count: Int {
        return items.count
    }
    
    var title: String {
        switch self {
        case .summary:
            return ""
        case .starring:
            return "Starring"
        case .similar:
            return "Similar Movies"
        case .recomended:
            return "Recomended Movies"
        case .reviews:
            return "User Reviews"
        }
    }
}

struct MovieCast: Decodable {
    let id: Int?
    let cast: [Actor]?
}

struct Actor: Decodable {
    let adult: Bool?
    let gender: Int?
    let id: Int?
    let knownForDepartment: String?
    let name: String?
    let originalName: String?
    let popularity: Double?
    let profilePath: String?
    let castId: Int
    let character: String?
    let creditId: String?
    let order: Int?
    
    enum CodingKeys: String, CodingKey {
        case adult
        case gender
        case id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castId = "cast_id"
        case character
        case creditId = "credit_id"
        case order
    }
}

struct ActorModel {
    let name: String
    let profileImage: Data?
}

struct ReviewResponse: Decodable {
    let id: Int?
    let page: Int?
    let results: [Review]?
    let totalPages: Int?
    let totalResults: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case page
        case results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct Review: Decodable {
    let author: String?
    let authorDetails: User?
    let content: String?
    let createdAt: String?
    let id: String?
    let updatedAt: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case author
        case authorDetails = "author_details"
        case content
        case createdAt = "created_at"
        case id
        case updatedAt = "updated_at"
        case url
    }
}

struct User: Decodable {
    let name: String?
    let username: String?
    let avatarPath: String?
    let rating: Double?
    
    enum CodingKeys: String, CodingKey {
        case name
        case username
        case avatarPath = "avatar_path"
        case rating
    }
}

struct ReviewModel {
    let name: String
    let rating: Double
    let content: String
    let avatar: Data?
}
