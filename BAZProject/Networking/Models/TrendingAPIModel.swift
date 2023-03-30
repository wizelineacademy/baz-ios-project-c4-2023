//
//  TrendingAPIModel.swift
//  BAZProject
//
//  Created by gescarcega on 29/03/23.
//

import Foundation

struct TrendingAPIModel: Decodable {
    var results: [Movie]
    
    private enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    static func decode(from data: Data) -> TrendingAPIModel? {
        return try? JSONDecoder().decode(self, from: data)
    }
}
