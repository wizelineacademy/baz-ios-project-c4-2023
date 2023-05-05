//
//  FavoriteMovies.swift
//  BAZProject
//
//  Created by Carlos Garcia on 04/05/23.
//

import Foundation

struct FavoriteMovies: Codable {
    
    var movies: [MovieInfo]
    
    enum CodingKeys: String, CodingKey {
        case movies = "movies"
    }
    
    init(movies: [MovieInfo]) {
        self.movies = movies
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        self.movies = try values.decode([Movie].self, forKey: .movies)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        if let movies = self.movies as? [Movie] {
            try container.encode(movies, forKey: .movies)
        }
    }
    
    public mutating func updateMovies(_ movies: [MovieInfo]) {
        self.movies = movies as? [Movie] ?? []
    }

    public mutating func addMovie(_ movie: MovieInfo) {
        if let movie = movie as? Movie {
            self.movies.append(movie)
        } else if let movieFound = movie as? MovieFoundAdapter {
            self.movies.append(Movie(id: movieFound.id, title: movieFound.title, posterPath: movieFound.posterPath))
        }
    }

    public mutating func removeMovie(_ movie: MovieInfo) {
        if let index = self.movies.firstIndex(where: {$0.id == movie.id}) {
            self.movies.remove(at: index)
        }
    }

    public mutating func removeMovie(for movieID: Int) {
        if let index = self.movies.firstIndex(where: {$0.id == movieID}) {
            self.movies.remove(at: index)
        }
    }

    public func containMovie(for movieID: Int) -> Bool {
        movies.contains(where: {$0.id == movieID})
    }
}

struct User: Codable {
    var name: [Movie]
}
