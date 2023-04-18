//
//  MovieListViewModel.swift
//  BAZProject
//
//  Created by jmgarciaca on 17/04/23.
//

import UIKit

enum Enum_MovieFilters: String {
    case trending   = "Treanding"
    case nowPlaying = "Now Playing"
    case popular    = "Popular"
    case topRated   = "Top Rated"
    case upcoming   = "Upcoming"
}

class MovieListViewModel {
    private var filterType: Enum_MovieFilters = Enum_MovieFilters.trending
    private var movies: [Movie] = []
    
    init(_ filterType: Enum_MovieFilters) {
        self.filterType = filterType
    }
    
}

extension MovieListViewModel {
    
    func numberOfSections() -> Int {
        1
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        movies.count
    }
    
    func movieAtIndex(_ index: Int) -> MovieViewModel? {
        guard let movie = self.movies[safe: index] else { return nil }
        
        return MovieViewModel(movie)
    }
    
    private func setMovies(_ movies: [Movie]) {
        self.movies = movies
    }
    
    func applyFilter(_ filterType: Enum_MovieFilters? = nil, completion: @escaping () -> ()) {
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
    
    func getTitle() -> String {
        self.filterType.rawValue
    }
}
