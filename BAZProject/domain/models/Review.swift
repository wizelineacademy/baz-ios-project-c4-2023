//
//  Review.swift
//  BAZProject
//
//  Created by Ivan Tecpanecatl Martinez on 16/04/23.
//

import Foundation

struct ReviewResponse: Codable {
    let results: [Review]
}

struct Review: Codable {
    let author: String
    let content: String
    let rating: Int?
    let createdAt: String
    
    private enum CodingKeys: String, CodingKey {
        case author
        case content
        case createdAt = "created_at"
        case authorDetails = "author_details"
        case rating
    }
}

extension Review {
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try container.decode(String.self, forKey: .author)
        self.content = try container.decode(String.self, forKey: .content)
        let authorDetails = try container.nestedContainer(keyedBy: CodingKeys.self, forKey: .authorDetails)
        self.rating = try? authorDetails.decode(Int.self, forKey: .rating)
        self.createdAt = try container.decode(String.self, forKey: .createdAt)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(author, forKey: .author)
        try container.encode(content, forKey: .content)
        try container.encode(rating, forKey: .rating)
        try container.encode(createdAt, forKey: .createdAt)
    }
}
