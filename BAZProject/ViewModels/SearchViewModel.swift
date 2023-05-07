//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by jmgarciaca on 19/04/23.
//

import UIKit


// MARK: - A protocol for making objects searchable with a query string.
protocol SearchableProtocol {

    /// Search for objects matching a given query.
    /// - Parameter query: A query string used to search for objects.
    /// - Parameter completion: A closure that will be called once the search is complete.
    func search(query: String, completion: @escaping () -> ())
}

// MARK: - SearchViewModel
class SearchViewModel {
    private var movies: [Movie] = []
}

extension SearchViewModel {
    var title: String {
        "Search"
    }
}

extension SearchViewModel {
    
    /// Returns the number of sections in the search results table view.
    /// - Returns: The number of sections in the search results table view.
    func numberOfSections() -> Int {
        1
    }
    
    /// Returns the number of rows in the given section of the search results table view.
    /// - Parameter section: The section of the search results table view.
    /// - Returns: The number of rows in the given section of the search results table view.
    func numberOfRowsInSection(_ section: Int) -> Int {
        movies.count
    }
    
    /// Returns a movie view model for the movie at the given index in the search results.
    /// - Parameter index: The index of the movie in the search results.
    /// - Returns: A movie view model for the movie at the given index in the search results, or nil if the index is out of range.
    func movieAtIndex(_ index: Int) -> MovieViewModel? {
        guard let movie = self.movies[safe: index] else { return nil }
        
        return MovieViewModel(movie)
    }
    
    /// Sets the search results to the given list of movies.
    /// - Parameter movies: A list of movies to set as the search results.
    func setMovies(_ movies: [Movie]) {
        self.movies = movies
    }
}

// MARK: - SearchableProtocol
extension SearchViewModel: SearchableProtocol {
    
    /// Searches for movies using the provided query.
    /// - Parameter query: The search query.
    /// - Parameter completion: The completion block to be executed when the search is complete.
    func search(query: String, completion: @escaping () -> ()) {
        // Get the URL for the search query using the `Endpoint` struct.
        let url: URL? = Endpoint.search(query: query).url
        
        // Create a resource to load data from the `MovieList` endpoint using the `Resource` struct.
        let resource = Resource<MovieList>(url: url) { data in
            return try? JSONDecoder().decode(MovieList.self, from: data)
        }
        
        // Load the `resource` using the `load` method of the `MovieAPI` class.
        MovieAPI().load(resource: resource) { [weak self] result in
            if let movieList = result {
                // If the movie list was successfully retrieved, set the movies in the `SearchViewModel`.
                self?.setMovies(movieList.results)
                completion()
            }
        }
    }
}
