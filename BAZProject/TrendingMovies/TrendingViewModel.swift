//
//  TrendingModel.swift
//  BAZProject
//
//  Created by Manuel S on 28/03/23.
//

import Foundation


final class TrendingViewModel: MoviesListProtocol {
   
    var movies = Box(value: [ListMoviesProtocol]())
    
    func getmovies() {
        let movieApi = MovieAPI()
        movieApi.getMovies { [weak self] moviearray in
            self?.movies.value = moviearray
        }
    }
    
    func bindMovies(_ listener: @escaping () -> Void) {
        movies.listener = listener
    }
    
    func getMovieCount() -> Int {
        movies.value.count
    }
    
    func getTitle(index: Int) -> String? {
        movies.value[index].title
    }
    
}
