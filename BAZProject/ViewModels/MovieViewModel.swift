//
//  MovieViewModel.swift
//  BAZProject
//
//  Created by jmgarciaca on 30/03/23.
//

import Foundation

struct MovieViewModel {
    private let movie:Movie
    
    init(_ movie: Movie) {
        self.movie = movie
    }
}

extension MovieViewModel {
    var title: String { movie.title }
    var poster_path: String { "https://image.tmdb.org/t/p/w500/\(self.movie.poster_path)" }
}
