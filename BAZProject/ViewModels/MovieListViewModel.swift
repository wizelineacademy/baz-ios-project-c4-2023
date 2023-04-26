//
//  MovieListViewModel.swift
//  BAZProject
//
//  Created by jmgarciaca on 17/04/23.
//

import UIKit

/**
Enumerated type that represents different filters for movies.
*/
enum MovieFilter: String {
    /// Represents trending movies.
    case trending   = "Treanding"

    /// Represents movies currently playing.
    case nowPlaying = "Now Playing"

    /// Represents popular movies.
    case popular    = "Popular"

    /// Represents top rated movies.
    case topRated   = "Top Rated"

    /// Represents upcoming movies.
    case upcoming   = "Upcoming"
}

class MovieListViewModel {
    
    // MARK: - Private Properties
    
    private var filterType: MovieFilter = MovieFilter.trending
    private var movies: [Movie] = []
    
    // MARK: - Initializer

    /**
        Initializes a new instance of the `MovieListViewModel` class with a specified filter type.
     
        - Parameters:
            - filterType: The type of filter to use when managing the movie list.
     */
    init(_ filterType: MovieFilter) {
        self.filterType = filterType
    }
    
}

extension MovieListViewModel {
    
    /**
        Returns the number of sections in the movie list.
     
        - Returns: The number of sections, which is always 1.
    */
    func numberOfSections() -> Int {
        1
    }
    
    /**
        Returns the number of rows in a given section of the movie list.
     
        - Parameter section: An integer value representing the section number.
        - Returns: The number of rows in the section, which is equal to the number of movies in the list.
    */
    func numberOfRowsInSection(_ section: Int) -> Int {
        movies.count
    }
    
    /**
        Returns the movie view model for the movie at a given index.
     
        - Parameter index: An integer value representing the index of the movie in the list.
        - Returns: An optional `MovieViewModel` object representing the movie view model for the movie at the given index. If the index is out of bounds, `nil` is returned.
    */
    func movieAtIndex(_ index: Int) -> MovieViewModel? {
        guard let movie = self.movies[safe: index] else { return nil }
        
        return MovieViewModel(movie)
    }
    
    /**
        Sets the movies in the movie list to a given array of movies.
     
        - Parameter movies: An array of `Movie` objects representing the movies to set in the list.
    */
    func setMovies(_ movies: [Movie]) {
        self.movies = movies
    }
    
    /**
        Applies a filter to the movie list and loads the filtered movies from the API.
     
        - Parameter filterType: An optional `Enum_MovieFilters` value representing the filter to apply. If `nil`, the current filter type is used.
        - Parameter completion: A closure to be executed when the filtered movies have been loaded. This closure takes no parameters and has no return value.
    */
    func applyMovieFilter(_ filterType: MovieFilter? = nil, completion: @escaping () -> ()) {
        var url: URL?
        
        if let filterType = filterType {
            self.filterType = filterType
        }
        
        switch self.filterType {
        case .trending:
            url = Endpoint.trending.url
        case .nowPlaying:
            url = Endpoint.nowPlaying.url
        case .popular:
            url = Endpoint.popular.url
        case .topRated:
            url = Endpoint.topRated.url
        case .upcoming:
            url = Endpoint.upcoming.url
        }
        
        let resource = Resource<MovieList>(url: url) { data in
            return try? JSONDecoder().decode(MovieList.self, from: data)
        }
        
        MovieAPI().load(resource: resource) { [weak self] result in
            if let movieList = result {
                self?.setMovies(movieList.results)
                completion()
            }
        }
    }
    
    /**
        Returns the title of the movie list based on the current filter type.
     
        - Returns: A string representing the title of the movie list.
    */
    func getTitle() -> String {
        self.filterType.rawValue
    }
}
