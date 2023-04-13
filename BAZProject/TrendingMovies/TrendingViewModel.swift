//
//  TrendingModel.swift
//  BAZProject
//
//  Created by Manuel S on 28/03/23.
//

import Foundation


class TrendingViewModel: MoviesListProtocol {
   
    var movies: [ListMoviesProtocol]?
    
    func getmovies(_ completion: @escaping () -> Void) {
        let movieApi = MovieAPI()
        movieApi.getMovies { [weak self] moviearray in
            self?.movies = moviearray
            completion()
        }
    }
    
    func getMovieCount() -> Int {
        movies?.count ?? 0
    }
    
    func getTitle(index: Int) -> String? {
        movies?[index].title
    }
    
}
