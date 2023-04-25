//
//  Movie.swift
//  BAZProject
//
//  Created by Ben Frank V. on 24/04/23.
//

import Foundation

struct Movie: Decodable, Equatable {
    let id: Int
    let title: String
    let poster_path: String?
}
