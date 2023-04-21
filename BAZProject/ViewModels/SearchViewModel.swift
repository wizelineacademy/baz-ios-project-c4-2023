//
//  SearchViewModel.swift
//  BAZProject
//
//  Created by jmgarciaca on 19/04/23.
//

import UIKit

protocol SearchableProtocol {
    func search(query: String, completion: @escaping () -> ())
}

class SearchViewModel {
    private var movies: [Movie] = []
}

extension SearchViewModel {
    
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
}

extension SearchViewModel: SearchableProtocol {
    func search(query: String, completion: @escaping () -> ()) {
        let url: URL? = Endpoint.search(query: query).url
        
        let resource = Resource<MovieList>(url: url) { data in
            let str = String(decoding: data, as: UTF8.self)
            return try? JSONDecoder().decode(MovieList.self, from: data)
        }
        
        MovieAPI().load(resource: resource) { [weak self] result in
            if let movieList = result {
                self?.setMovies(movieList.results)
                completion()
            }
        }
        
    }
    
}
