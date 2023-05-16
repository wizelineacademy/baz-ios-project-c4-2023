//
//  Review.swift
//  BAZProject
//
//  Created by Octavio Labastida Luna on 07/05/23.
//

import Foundation

/// Protocolo que desacopla la estructura de AuthorDetail
protocol AuthorDetailsProtocol{
    var name: String { get set }
    var username: String { get set }
    var avatarPath: String? { get set }
    var rating: Double? { get set }
    var urlAvatar: URL? { get }
}
/// Protocolo que desacopla la estructura de una Reseña
protocol ReviewProtocol{
    var author: String { get set }
    var authorDetails: AuthorDetails { get set }
    var content: String { get set }
    var createdAt: String { get set }
    var id: String { get set }
    var updatedAt: String { get set }
    var url: String { get set }
}

// MARK: - ReviewResult

///Estructura de una respuesta que devuelve el servidor de MoviDB
struct ReviewResult: Codable {
    var id, page: Int
    var results: [Review]
    var totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case id, page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Review

/// Estructura de una reseña
struct Review: Codable, ReviewProtocol{
    var author: String
    var authorDetails: AuthorDetails
    var content, createdAt, id, updatedAt: String
    var url: String

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

// MARK: - AuthorDetails
///Estructura de un Autor de reseña
struct AuthorDetails: Codable, AuthorDetailsProtocol {
    var name, username: String
    var avatarPath: String?
    var rating: Double?
    var urlAvatar: URL?{
        return MovieDetailInfo.image(avatarPath ?? "").imageUrl
    }
    
    enum CodingKeys: String, CodingKey {
        case name, username
        case avatarPath = "avatar_path"
        case rating
    }
}
