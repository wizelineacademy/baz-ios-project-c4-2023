//
//  MoviesResponse.swift
//  BAZProject
//
//  Created by Carlos Garcia on 07/04/23.
//

import Foundation

struct ServiceResponse<Response: Decodable>: Decodable {
    var result: Response?
    var statusMessage: String?
    
    enum CodingKeys: String, CodingKey {
        case result = "results"
        case statusMessage = "status_message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.result = try? values.decode(Response.self, forKey: .result)
        self.statusMessage = try? values.decode(String.self, forKey: .statusMessage)
    }
}
