//
//  MovieViewModel.swift
//  BAZProject
//
//  Created by jmgarciaca on 30/03/23.
//

import Foundation

/**
A view model for a movie object.
*/
struct MovieViewModel {
    
    // MARK: - Properties
    
    /// The underlying movie object.
    private let movie:Movie
    
    private let dateFormatter = DateFormatter()
    
    // MARK: - Initialization
    
    /// Initializes a new instance of `MovieViewModel`.
    /// - Parameter movie: The movie object to be used as the underlying model.
    init(_ movie: Movie) {
        self.movie = movie
    }
}

extension MovieViewModel {
    
    /// The title of the movie. If the title is nil, an empty string is returned.
    /// - Returns: A string representing the title of the movie.
    var title: String {
        return movie.title ?? ""
    }
    
    /// The URL path of the movie's poster image. If the poster path is nil, nil is returned.
    /// - Returns: An optional string representing the URL path of the poster image.
    var poster_path: String? {
        if let poster_path = self.movie.poster_path {
            return "https://image.tmdb.org/t/p/w500/\(poster_path)"
        } else {
            return nil
        }
    }
    
    //TODO: Prueba unitaria
    var overview: String {
        return movie.overview ?? ""
    }
    
    var year: String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let release_date = movie.release_date, let date = dateFormatter.date(from: release_date) else {
            return ""
        }
        
        return "\(Calendar.current.component(.year, from: date))"
    }
    
    var vote_average: String {
        return "\((Int(movie.vote_average ?? 0) ) * 10 )% de coincidencia"
    }
}
