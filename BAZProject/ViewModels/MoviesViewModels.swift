//
//  MoviesViewModels.swift
//  BAZProject
//
//  Created by nmorenoa on 30/03/23.
//

import Foundation
import UIKit

struct MoviesViewModels{
    private let movie: Movie
}

extension MoviesViewModels{
    init(_ movie: Movie) {
        self.movie = movie
    }
}

extension MoviesViewModels{
    var title: String {
        return self.movie.title
    }
    
    var poster_path: Data {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(self.movie.poster_path)") else { return Data() }
        if let data = try? Data(contentsOf: url){
            return data
        }
        return Data()
    }
}

struct MoviesListViewModel{
    let movies: [Movie]
}

extension MoviesListViewModel {
    var numberOfSections: Int {
        return movies.count
    }
    
    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.movies.count
    }
    
    func movieAtIndex(_ index: Int) -> MoviesViewModels {
        let movie = self.movies[index]
        return MoviesViewModels(movie)
    }
}
