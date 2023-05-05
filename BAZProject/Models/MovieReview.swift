//
//  MovieReview.swift
//  BAZProject
//
//  Created by Carlos Garcia on 28/04/23.
//

import Foundation

struct MovieReview: MovieReviewInfo, Codable {
    var author: String
    var content: String
    
    enum CodingKeys: String, CodingKey {
        case author = "author"
        case content = "content"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.author = try values.decode(String.self, forKey: .author)
        self.content = try values.decode(String.self, forKey: .content)
    }
    
    init() {
        author = "1"
        content = "D"
    }
    
    func encode(to encoder: Encoder) throws {}
}
