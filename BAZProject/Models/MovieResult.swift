//
//  MovieResult.swift
//  BAZProject
//
//  Created by ksolano on 18/04/23.
//

import Foundation

// Get all data of petition from API
struct MovieResult: Decodable {
    var results: [Movie]
}
