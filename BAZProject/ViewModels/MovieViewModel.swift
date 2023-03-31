//
//  MovieViewModel.swift
//  BAZProject
//
//  Created by jmgarciaca on 30/03/23.
//

import Foundation

struct MovieListViewModel {
    let movies: [Movie]
}

extension MovieListViewModel {
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.movies.count
    }
    
    func movieAtIndex(_ index: Int) -> MovieViewModel {
        let movie = self.movies[index]
        return MovieViewModel(movie)
    }
}

struct MovieViewModel {
    private let movie:Movie
}

extension MovieViewModel {
    init(_ movie: Movie) {
        self.movie = movie
    }
}

extension MovieViewModel {
    var title: String {
        return self.movie.title
    }
    
    var poster_path: String {
        return "https://image.tmdb.org/t/p/w500/\(self.movie.poster_path)"
    }
}
