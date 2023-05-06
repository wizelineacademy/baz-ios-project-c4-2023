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
final class MovieViewModel {
    
    // MARK: - Properties
    
    /// The movie object associated with this view model.
    private let movie:Movie
    
    /// An array of actors associated with this movie.
    private var actors: [Actor] = []
    
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
    

    /// The overview of the movie. If the overview is nil, an empty string is returned.
    /// - Returns: A string representing the overview of the movie.
    var overview: String {
        return movie.overview ?? ""
    }
    
    /// The year of the movie's release date. If the release date is nil, an empty string is returned.
    /// - Returns: A string representing the year of the movie's release date.
    var year: String {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        guard let release_date = movie.release_date, let date = dateFormatter.date(from: release_date) else {
            return ""
        }
        
        return "\(Calendar.current.component(.year, from: date))"
    }
    
    /// The vote average of the movie. If the vote average is nil, 0% is returned.
    /// - Returns: A string representing the vote average of the movie.
    var vote_average: String {
        return "\((Int(movie.vote_average ?? 0) ) * 10 )% de calificación"
    }
}

extension MovieViewModel {
    
    /// Set the actors for the movie.
    /// - Parameter actors: An array of `Actor` objects representing the cast of the movie.
    func setActors(_ actors: [Actor]) {
        self.actors = actors
    }
    
    /// Get a string representation of the top three actors in the movie.
    /// - Returns: A string containing the names of the top three actors in the movie, separated by commas.
    private func getCast() -> String {
        String(self.actors.prefix(3).reduce("") { "\($0), \($1.name ?? "")" }.dropFirst(2))
    }
    
    /// Load the cast of the movie from the API and call the completion handler with the cast as a string.
    /// - Parameter completion: A closure that takes a string containing the cast of the movie as its only parameter.
    func loadCast(completion: @escaping (String) -> ()) {
        let resource = Resource<Credits>(url: Endpoint.credits(id_movie: movie.id).url) { data in
            return try? JSONDecoder().decode(Credits.self, from: data)
        }
        
        MovieAPI().load(resource: resource) { [weak self] result in
            if let actors = result {
                self?.setActors(actors.cast)
                completion(self?.getCast() ?? "")
            }
        }
    }
    
    /// Load the reviews for the movie from the API and call the completion handler with an array of `Review` objects.
    /// - Parameter completion: A closure that takes an array of `Review` objects as its only parameter.
    func loadReviews(completion: @escaping ([Review]) -> ()) {
        let resource = Resource<ReviewList>(url: Endpoint.reviews(id_movie: movie.id).url) { data in
            return try? JSONDecoder().decode(ReviewList.self, from: data)
        }
        
        MovieAPI().load(resource: resource) { result in
            if let reviews = result {
                completion(reviews.results)
            }
        }
    }
}
