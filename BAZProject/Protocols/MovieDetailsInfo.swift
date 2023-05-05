//
//  MovieDetailsInfo.swift
//  BAZProject
//
//  Created by Carlos Garcia on 28/04/23.
//

import Foundation

protocol MovieDetailsInfo: MovieInfo {
    var overview: String? { get }
    var backdropPath: String? { get }
    var releaseDate: String { get }
    var runtime: Int { get }
    var voteAverage: Double { get }
    var voteCount: Int { get }
    var credits: MovieCreditsInfo? { get set }
}
