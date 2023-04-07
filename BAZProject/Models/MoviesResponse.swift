//
//  MoviesResponse.swift
//  BAZProject
//
//  Created by Carlos Garcia on 07/04/23.
//

import Foundation

struct ServiceResponse<Response: Decodable>: Decodable {
    var result: Response?
    
    enum CodingKeys: String, CodingKey {
        case result = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try values.decode(Response.self, forKey: .result)
    }
}
