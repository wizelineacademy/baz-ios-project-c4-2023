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
}
