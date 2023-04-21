//
//  MovieInfo.swift
//  BAZProject
//
//  Created by Carlos Garcia on 30/03/23.
//

import Foundation

protocol MovieInfo {
    var id: Int { get }
    var title: String { get }
    var posterPath: String { get }
    var overview: String { get }
    var backdropPath: String? { get }
}
