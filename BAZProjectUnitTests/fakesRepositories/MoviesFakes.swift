//
//  MoviesFakes.swift
//  BAZProjectUnitTests
//
//  Created by Ivan Tecpanecatl Martinez on 03/05/23.
//

import Foundation
@testable import BAZProject

class MoviesFakes: MoviesRepository {

    private var moviesFakes: [Movie] = []
    private var relatedMovies: [Movie] = []

    private func setupMovies(filter: Filters) {
        switch filter {
        case .trending:
            moviesFakes = generateMovies(2)
        case .nowPlaying:
            moviesFakes = generateMovies(3)
        case .popular:
            moviesFakes = generateMovies(4)
        case .topRated:
            moviesFakes = generateMovies(5)
        case .upcoming:
            moviesFakes = generateMovies(6)
        case .similar:
            relatedMovies = generateMovies(7)
        case .recommendations:
            relatedMovies = generateMovies(8)
        }
    }

    func getMovies(filter: Filters, completion: @escaping ([Movie]) -> Void) {
        setupMovies(filter: filter)
        completion(moviesFakes)
    }

    func getRelatedMovies(filter: Filters, movieID: Int, completion: @escaping ([Movie]) -> Void) {
        setupMovies(filter: filter)
        completion(relatedMovies)
    }

    func getUrlFilter(_ filter: Filters, _ movieID: Int?) -> String {
        return ""
    }
}
